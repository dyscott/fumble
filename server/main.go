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
	"github.com/pocketbase/pocketbase/plugins/migratecmd"
)

func main() {
	app := pocketbase.New()

	migratecmd.MustRegister(app, app.RootCmd, migratecmd.Config{
		Automigrate: false,
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
			if err := potentialMatchesQuery.All(&potentialMatches); err != nil {
				return c.JSON(http.StatusInternalServerError, err)
			}

			return c.JSON(200, potentialMatches)
		})

		return nil
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
