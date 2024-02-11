package main

import (
	"fmt"
	"log"
	"os"

	"github.com/labstack/echo/v5"
	"github.com/pocketbase/dbx"
	"github.com/pocketbase/pocketbase"
	"github.com/pocketbase/pocketbase/apis"
	"github.com/pocketbase/pocketbase/core"
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

// a function which will query the match table and return a list of potential matches (people who are online and are looking for a match, and who you are not already matched with)
func wingman(app *pocketbase.PocketBase, sourceId string) []string {
	// the match table has 3 columns: source_id, target_id, and status
	// the user table has only 2 columns that are relevant: id, preference

	db := app.Dao().DB()
	sourcePreferenceQuery := db.Select("classes").From("users").Where(dbx.NewExp("id = {:sourceId}", dbx.Params{"sourceId": sourceId}))
	var sourcePreference string
	if err := sourcePreferenceQuery.Row(&sourcePreference); err != nil {
    log.Fatal(err)
	}

	// // create a query to get all users who are not the source, or in the allTargetsAlreadyMatched list (and where the user's profile is complete, and the user has the same preference as the source_id)
	// potentialMatches := db.Select("id").From("users").Where(query.NotEq("id", sourceId)).
	// 	AndWhere(query.NotIn("id", allTargetsAlreadyMatched)).
	// 	AndWhere(query.Eq("profileComplete", true)).
	// 	AndWhere(query.Eq("preference", sourcePreference))


	// create a join query to get all target_id who have the same preference as the source_id, and whose status is not accept or reject
	// the issue is, there will never be a status of none because the row would just not exist in the match table
	// so we need to get all target_id who have the same preference as the source_id, and who are not already matched with the source_id


	// Define the query to get all potential matches
	potentialMatches := db.Select("users.id").
										From("users").
										LeftJoin("matches", dbx.NewExp("users.id = matches.targetId")).
										Where(dbx.NewExp("matches.sourceId IS NULL")).
										AndWhere(dbx.Not(dbx.NewExp("users.id = {:sourceId}", dbx.Params{"sourceId": sourceId} ) ) ).
										AndWhere(dbx.NewExp("users.profileComplete = TRUE")).
										AndWhere(dbx.NewExp("users.classes = {:sourcePreference}", dbx.Params{"sourcePreference": sourcePreference}))

	// now return the potential matches as a JSON response
	rows, err := potentialMatches.Rows()
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var matches []string
	for rows.Next() {
		var match string
		rows.Scan(&match)
		matches = append(matches, match)
	}
	
	fmt.Println(matches)

	// return the matches as a JSON response
	return matches
}

func main() {
	app := pocketbase.New()

	// wingman(app, "uigv0i9ynpgoibd")

	// serves static files from the provided public dir (if exists)
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		e.Router.GET("/*", apis.StaticDirectoryHandler(os.DirFS("./pb_public/web"), false))
		// create a route to handle the wingman function
		e.Router.GET("/api/wingman", func(c echo.Context) error {
			matches := wingman(app, "uigv0i9ynpgoibd")
			return c.JSON(200, matches)
		})
		return nil
	})



	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
