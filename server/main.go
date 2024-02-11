package main

import (
	"log"
	"net/http"
	"os"

	"github.com/labstack/echo/v5"
	"github.com/pocketbase/dbx"
	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/apis"
	"github.com/pocketbase/pocketbase/core"
	"github.com/pocketbase/pocketbase/models"
)

// User represents the structure of the users table
type User struct {
	ID              string `pocketbase:"id"`
	Preference      string `pocketbase:"classes"`
	profileComplete bool   `pocketbase:"profileComplete"`
}

// Match represents the structure of the matches table
type Match struct {
	Author string `pocketbase:"author"`
	Target string `pocketbase:"target"`
	Status string `pocketbase:"status"`
}

func main() {
	app := pocketbase.New()

	// serves static files from the provided public dir (if exists)
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		e.Router.GET("/*", apis.StaticDirectoryHandler(os.DirFS("./pb_public/web"), false))

		// Create a route for Linkin -> List made matches
		e.Router.GET("/api/fumble/linkin", func(c echo.Context) error {
			user, _ := c.Get(apis.ContextAuthRecordKey).(*models.Record)
			id := user.GetString("id")

			dao := app.Dao()

			query := dao.
				RecordQuery("matches").
				AndWhere(dbx.NewExp("author = {:id} OR target = {:id}", dbx.Params{"id": id})).
				AndWhere(dbx.NewExp("status = 'like'"))

			records := []*models.Record{}
			if err := query.All(&records); err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}

			match_counts := make(map[string]int)

			// Loop through the records and count the matches
			for _, record := range records {
				var match string
				if record.GetString("author") == id {
					match = record.GetString("target")
				} else {
					match = record.GetString("author")
				}
				// Add or increment the match count
				if _, ok := match_counts[match]; ok {
					match_counts[match]++
				} else {
					match_counts[match] = 1
				}
			}

			// Create a list of matches
			matches := make([]string, 0)
			for match, count := range match_counts {
				if count > 1 {
					matches = append(matches, match)
				}
			}

			// Query the users table for the matches
			// Convert matches to []interface{}
			interfaceSlice := make([]interface{}, len(matches))
			for i, v := range matches {
				interfaceSlice[i] = v
			}

			// Query the users table for the matches
			user_query := dao.
				RecordQuery("users").
				AndWhere(dbx.In("id", interfaceSlice...))

			users := []*models.Record{}
			if err := user_query.All(&users); err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}

			return c.JSON(http.StatusOK, users)
		},
		/* optional middlewares */)

		// Create a route for Wingman -> Find potential matches
		e.Router.GET("/api/fumble/wingman", func(c echo.Context) error {
			user, _ := c.Get(apis.ContextAuthRecordKey).(*models.Record)
			sourceId := user.GetString("id")

			dao := app.Dao()
			//db := dao.DB()

			sourcePreference := user.GetString("classes")

			// Define the query to get all potential matches
			// potentialMatches := db.Select("users.id").
			// 	From("users").
			// 	LeftJoin("matches", dbx.And(dbx.NewExp("users.id = matches.target"), dbx.NewExp("matches.author = {:sourceId}", dbx.Params{"sourceId": sourceId}))).
			// 	// Where(dbx.NewExp("matches.author IS NULL")).
			// 	Where(dbx.Not(dbx.NewExp("users.id = {:sourceId}", dbx.Params{"sourceId": sourceId}))).
			// 	AndWhere(dbx.NewExp("users.profileComplete = TRUE")).
			// 	AndWhere(dbx.NewExp("users.classes = {:sourcePreference}", dbx.Params{"sourcePreference": sourcePreference}))

			// // now return the potential matches as a JSON response
			// rows, err := potentialMatches.Rows()
			// if err != nil {
			// 	log.Fatal(err)
			// }
			// defer rows.Close()

			// var matches []string
			// for rows.Next() {
			// 	var match string
			// 	rows.Scan(&match)
			// 	matches = append(matches, match)
			// }

			// // Query the users table for the matches
			// // Convert matches to []interface{}
			// interfaceSlice := make([]interface{}, len(matches))
			// for i, v := range matches {
			// 	interfaceSlice[i] = v
			// }

			// // Query the users table for the matches
			// user_query := dao.
			potentialMatchesQuery := dao.
				RecordQuery("users").
				AndWhere(dbx.NewExp("id != {:id}", dbx.Params{"id": sourceId})).
				AndWhere(dbx.NewExp("classes = {:classes}", dbx.Params{"classes": sourcePreference}))

			potentialMatches := []*models.Record{}
			if err := potentialMatchesQuery.All(&potentialMatches); err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}

			// Get the user's existing swipes (likes / rejects)
			existingSwipesQuery := dao.
				RecordQuery("matches").
				AndWhere(dbx.NewExp("author = {:id}", dbx.Params{"id": sourceId}))

			existingSwipes := []*models.Record{}
			if err := existingSwipesQuery.All(&existingSwipes); err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}

			// Create a map of existing swipes
			existingSwipesMap := make(map[string]string)
			for _, swipe := range existingSwipes {
				existingSwipesMap[swipe.GetString("target")] = swipe.GetString("status")
			}

			// Filter out the existing swipes from the potential matches
			filteredPotentialMatches := make([]*models.Record, 0)
			for _, match := range potentialMatches {
				if _, ok := existingSwipesMap[match.GetString("id")]; !ok {
					filteredPotentialMatches = append(filteredPotentialMatches, match)
				}
			}

			return c.JSON(200, filteredPotentialMatches)
		})

		return nil
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
