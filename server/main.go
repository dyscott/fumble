package main

import (
	"log"
	"math"
	"net/http"
	"os"
	"sort"

	"github.com/labstack/echo/v5"
	"github.com/pocketbase/dbx"
	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/apis"
	"github.com/pocketbase/pocketbase/core"
	"github.com/pocketbase/pocketbase/daos"
	"github.com/pocketbase/pocketbase/models"
	"github.com/pocketbase/pocketbase/plugins/migratecmd"
)

// User represents the structure of the users table
type User struct {
	ID              string `pocketbase:"id"`
	Preference      string `pocketbase:"classes"`
	profileComplete bool   `pocketbase:"profileComplete"`
	ELO             int `pocketbase:"elo"`
}

// Match represents the structure of the matches table
type Match struct {
	Author string `pocketbase:"author"`
	Target string `pocketbase:"target"`
	Status string `pocketbase:"status"`
}

const K = 32 // K-factor determines how much a user's rating should change after a match
func calculateExpectedScore(ratingA, ratingB int) float64 {
	return 1.0 / (1.0 + math.Pow(10, float64(ratingB-ratingA)/400))
}
func adjustELO(app *pocketbase.PocketBase, sourceId, targetId string, liked bool) int {
	// Get the user's ELO rating
	userQuery := app.Dao().
	RecordQuery("users").
	Where(dbx.NewExp("id = {:id}", dbx.Params{"id": sourceId}))

	user := &User{}
	if err := userQuery.One(user); err != nil {
		// Handle error
		log.Fatal(err)
	}

	sourceELO := user.ELO
	// Get the target's ELO rating
	targetQuery := app.Dao().
	RecordQuery("users").	
	Where(dbx.NewExp("id = {:id}", dbx.Params{"id": targetId}))

	target := &User{}
	if err := targetQuery.One(target); err != nil {
		// Handle error
		log.Fatal(err)
	}
	
	targetELO := target.ELO

	// Calculate the new ELO rating
	expectedTarget := calculateExpectedScore(targetELO, sourceELO)

	// If the user liked the target
	if liked {
		targetELO += int(K * (0 - expectedTarget))
	} else {
		targetELO += int(K * (1 - expectedTarget))
	}

	// update the target's ELO rating
	return targetELO
}


func main() {
	app := pocketbase.New()

	migratecmd.MustRegister(app, app.RootCmd, migratecmd.Config{
		Automigrate: false,
	})

	app.OnRecordBeforeUpdateRequest("matches").Add(func(e *core.RecordUpdateEvent) error {
			record := e.Record
			// If the match status is "like"
			matchStatus := record.GetString("status") == "like" 
			// Get the source and target IDs
			sourceId := record.GetString("author")
			targetId := record.GetString("target")
			// Update the target's ELO rating
			targetELO := adjustELO(app, sourceId, targetId, matchStatus)
			record.Set("elo", targetELO)
		return nil
	})

	// serves static files from the provided public dir (if exists)
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		e.Router.GET("/*", apis.StaticDirectoryHandler(os.DirFS("./pb_public/web"), false))
		// Create a route for Matches -> List made matches
		e.Router.GET("/api/fumble/matches", func(c echo.Context) error {
			user, _ := c.Get(apis.ContextAuthRecordKey).(*models.Record)
			id := user.GetString("id")

			dao := app.Dao()

			// Build the query to find matches for the user
			matchQuery := dao.
				RecordQuery("users").
				Where(dbx.Not(dbx.NewExp("users.id = {:id}", dbx.Params{"id": id}))).
				LeftJoin("matches", dbx.NewExp("users.id = matches.author")).
				AndWhere(dbx.NewExp("matches.status = 'like' AND matches.target = {:id}", dbx.Params{"id": id})).
				AndWhere(dbx.Exists(dbx.NewExp("SELECT 1 from matches WHERE author= {:id} AND target = users.id AND status = 'like'", dbx.Params{"id": id})))

			// Get the matches
			matches := []*models.Record{}
			if err := matchQuery.All(&matches); err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}

			return c.JSON(http.StatusOK, matches)
		},
		/* optional middlewares */)

		// Create a route for Wingman -> Find potential matches
		e.Router.GET("/api/fumble/wingman", func(c echo.Context) error {
			user, _ := c.Get(apis.ContextAuthRecordKey).(*models.Record)
			sourceId := user.GetString("id")

			dao := app.Dao()

			sourcePreference := user.GetString("classes")

			// Build the query to find potential matches
			potentialMatchesQuery := dao.RecordQuery("users").
				From("users").
				Where(dbx.Not(dbx.NewExp("users.id = {:sourceId}", dbx.Params{"sourceId": sourceId}))).
				AndWhere(dbx.NewExp("users.profileComplete = TRUE")).
				AndWhere(dbx.NewExp("users.classes = {:sourcePreference}", dbx.Params{"sourcePreference": sourcePreference})).
				AndWhere(dbx.NotExists(dbx.NewExp("SELECT 1 from matches WHERE (author = {:sourceId} AND target = users.id)", dbx.Params{"sourceId": sourceId})))

			// Get the potential matches
			potentialMatches := []*models.Record{}
			err := potentialMatchesQuery.All(&potentialMatches)
			if err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}
			// sort potential matches by whoever has the ELO rating closest to the source user
			sort.Slice(potentialMatches, func(i, j int) bool {
				return math.Abs(float64(potentialMatches[i].GetInt("elo") - user.GetInt("elo"))) < math.Abs(float64(potentialMatches[j].GetInt("elo") - user.GetInt("elo")))
			})

			return c.JSON(200, potentialMatches)
		})

		return nil
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
