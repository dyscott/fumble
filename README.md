![github repo badge: Frontend](https://img.shields.io/badge/Frontend-Flutter-181717?color=purple) ![github repo badge: Backend](https://img.shields.io/badge/Backend-PocketBase-181717?color=white) ![github repo badge: Backend](https://img.shields.io/badge/Backend-Golang-181717?color=blue) ![github repo badge: Database](https://img.shields.io/badge/Database-SQLite-181717?color=blue) ![github repo badge: Cloud Provider](https://img.shields.io/badge/Cloud%20Provider-Oracle%20Cloud-181717?color=orange) 
# Fumble
![image](https://github.com/dyscott/fumble/assets/6569519/b82e8d4f-5c0c-4350-bb02-cc602fb44684)

Fumble addresses the challenge CS students face in finding reliable project collaborators by facilitating connections through a matching platform and fostering meaningful communication with a seamless messaging feature. Users can sign up via email or Discord, swipe through profiles for potential matches, and utilize profile editing tools to customize their information, enhancing the collaborative experience in educational projects.

## Inspiration

As CS students move up in their classes, group projects and assignments become more and more common and complex. However, despite the numerous group projects/assignments that one does throughout their educational career, a recurring challenge that we face is finding reliable teammates to collaborate with. Enter Fumble, our solution designed to simplify the process of finding project collaborators. More than just a matching platform, Fumble stands as an initial touchpoint, facilitating meaningful connections by not only showcasing fellow class members actively seeking teammates but also providing a seamless messaging feature to foster communication among matched users. With Fumble, the journey from solo struggles to collaborative triumphs becomes a shared adventure, transforming the educational experience for CS students.

## What it Does

Fumble facilitates connections between users and like-minded CS students to find partners for collaborative class projects. Our goal is to address the challenges CS students encounter when seeking partners on platforms like Piazza or Discord, where they often face a lack of responses or insufficient information about potential collaborators.

Upon opening the app, users are presented with the option to log in / register via email or Discord. The sign-up process requests a name, biography, profile image, and banner. The home screen allows users to swipe through other profiles, with a left swipe indicating rejection and a right swipe indicating a match. Additionally, users have access to a profile editing page where they can modify their profile image, banner cover, name, and biography. The app also includes a messaging feature, enabling users to communicate with their matches.

## Usage
### Hosted Demo
Currently, a demo of Fumble is hosted at https://fumble.dyscott.xyz/

### Self-Host
Requires [Go](https://go.dev/doc/install) and [Flutter](https://docs.flutter.dev/get-started/install) to be installed. Be sure to configure Flutter for each platform you want to build for.

Run the following commands in the backend directory to start the server:
```bash
cd server
go mod download
go run main.go serve
```

Run the following commands in the frontend directory to start the app:
```bash
cd client
flutter run
```

*Note: By default, the client will point to our PocketBase instance (fumble.dyscott.xyz). To change this, go into `client/lib/util/auth.dart` and change `pocketbase_url` to your local server*

## How we Built it

### Security

From the get-go, we prioritized security and privacy in the development of Fumble. We implemented OAuth 2.0 for user authentication, enabling convenient authentication via Discord sign-in. Alternatively, users can register and sign in to their account via email and password.

Our application is HTTPs by default, all passwords are hashed, and we have API Security Rules to ensure that only the user who owns the data can access it.

To prevent SQL Injection attacks, we never run raw SQL queries, our queries are managed by Pocketbase's DAO, which ensures that all queries are safe. We are also secured against JavaScript injection and XSS attacks through our use of Flutter, which does not run JavaScript or interface with the DOM at all.

Additional security improvements in the future could include End-to-End Encryption, email verification via SendGrid, and 2FA.

### Frontend

For the front end of Fumble, we utilized Flutter as our primary framework. Flutter is an open-source UI software development toolkit based on Dart. We used its rich set of pre-built widgets and tools to develop an intuitive and high-performing mobile app. The user can sign up or log in to a Fumble profile using their Discord or email credentials. After signing in, users have the option to add/edit their name, biography, profile photos, and to pick which courses they are seeking partners for.

Fumble's front end has been tested heavily on both Web and iOS. We haven't tested other platforms but Android and Desktop should also be supported.

### Backend

For the backend, we used Go and PocketBase. PocketBase implements several Backend as a Service (BaaS) features that can be run locally, such as user authentication, SQL database, and easy integration with Dart and Go which abstracts away REST API calls. 

We used PocketBase to store user data, including their name, biography, and courses they are seeking partners for. We also used PocketBase to store the matches between users and to facilitate messaging between users.

On top of Pocketbase, we developed two additional endpoints that execute advanced SQL queries. The first one, `wingman`, is responsible for aggregating potential matches to be displayed to each user. In the future, this endpoint could be expanded to include a matchmaking algorithm. The second one, `matches`, is responsible for determining successful matches (both users liked each other) which are shown in the Chat menu.

## Challenges we ran into

For this project, we navigated languages, frameworks, and development tools that were entirely unfamiliar to us at the beginning of the hackathon. We had to figure out how to integrate the different part of our mobile app development, which involved four users, into one cohesive product. By using branches and separating various pages and components of the project, we overcame these challenges and effectively developed Fumble.

## Accomplishments that we're proud of
For many on our team, this was our first experience creating a mobile app, and we are grateful for the opportunity to do so. We are also proud to have developed an app that facilitates socialization and collaboration for CS majors, helping combat the challenges associated with such a difficult major.

## What we learned

The entire team was unfamiliar with Flutter before starting this project, so we embarked on learning a new framework and programming language. For many of us, this was our first experience developing a mobile app, providing an opportunity to familiarize ourselves with Apple's code development tools and Xcode. We found the simplicity of the Flutter framework appealing and appreciated its capabilities in enabling us to create such a beautiful mobile app.

## What's next for Fumble

While we are satisfied with how Fumble came out, we recognize the potential for enhancements to elevate it even further. Our next steps include integrating a feedback form directly within the app. This will enable us to seamlessly gather valuable insights and suggestions from the community, allowing us to refine and optimize Fumble based on user input. Moreover, we envision enhancing the matchmaking algorithm by incorporating machine learning techniques. By training an AI model on user interactions—such as swipes to the right or left-we aim to make Fumble's matching system more intuitive and tailored to individual preferences. These improvements represent our commitment to continuous refinement, ensuring Fumble remains a dynamic and user-centric platform.

