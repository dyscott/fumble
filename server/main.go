package main

import (
    "log"
    "os"

    "github.com/pocketbase/pocketbase"
    "github.com/pocketbase/pocketbase/apis"
    "github.com/pocketbase/pocketbase/core"
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
        return nil
    })

    if err := app.Start(); err != nil {
        log.Fatal(err)
    }
}