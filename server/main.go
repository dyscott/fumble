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

// a function which will query the match table and return a list of potential matches (people who are online and are looking for a match, and who you are not already matched with)
// func wingman(app *pocketbase.App, user_id int64) {
// 		// query the match table for if my user id is in the user1 and has not already accepted or rejected the match
// 		app.DB.Query("SELECT * FROM match
// WHERE (user1 = ? AND user1_status = 'none')
// OR (user2 = ? AND user2_status = 'none'");
// ).All(func(row *pocketbase.Row) {

// 		})

// }

func main() {
	app := pocketbase.New()

	// serves static files from the provided public dir (if exists)
	app.OnBeforeServe().Add(func(e *core.ServeEvent) error {
		e.Router.GET("/*", apis.StaticDirectoryHandler(os.DirFS("./pb_public/web"), false))
		e.Router.GET("/api/fumble/racoon", func(c echo.Context) error {
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
			// Print the match counts
			for match, count := range match_counts {
				// Format prettily
				log.Printf("Match: %s, Count: %d", match, count)
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
		} /* optional middlewares */)

		return nil
	})

	if err := app.Start(); err != nil {
		log.Fatal(err)
	}
}
