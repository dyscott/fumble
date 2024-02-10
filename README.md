# Fumble

## Inspiration

As CS students move up in their classes, group projects and assignemnts become more and more common and complex. However, despite the numerous group projects/assignments that one does throughout their educational career, a recurring challenge that we face is finding reliable teammates you can collaborate and connect with. Enter Fumble, our solution designed to simplify the process of finding project collaborators. More than just a matching platform, Fumble stands as an initial touchpoint, facilitating meaningful connections by not only showcasing fellow class members actively seeking teammates but also providing a seamless messaging feature to foster communication among matched users. With Fumble, the journey from solo struggles to collaborative triumphs becomes a shared adventure, transforming the educational experience for CS students.

## What it Does

Fumble facilitates connections between users and like-minded CS students to find partners for collaborative class projects. Our goal is to address the challenges CS students encounter when seeking partners on platforms like Piazza or Discord, where they often face a lack of responses or insufficient information about potential collaborators.

Upon opening the app, users are presented with the option to log in via email or Discord, or to sign up. The sign-up process requests a name, biography, profile image, and banner. The home screen allows users to swipe through other profiles, with a left swipe indicating rejection and a right swipe indicating a match. Additionally, users have access to a profile editing page where they can modify their profile image, banner cover, name, and biography. The app also includes a messaging feature, enabling users to communicate with their matches.

## Demonstration

## How to Use
Run the following commands in the backend directory to start the server:

```bash
cd server
go mod download
go run main.go serve
```
## How we Built it
### Frontend

For the frontend of Fumble, we utilized Flutter as our primary framework. Flutter is an open-source UI software development toolkit based on Dart. We used its rich set of pre-built widgets and tools to develop an intuitive and high-performing mobile app. The user can seamlessly sign up or log into a Fumble profile using their Discord or email credentials. After signing in or logging in, users have the option to add/edit their name, biography and to pick which courses they are seeking partners for.

To host the app on mobile devices, we utilize Xcode and Apple Developer tools on iPhones.

### Backend

## Challenges we ran into

## Accomplishments that we're proud of

## What we learned

The entire team was unfamiliar with Flutter before starting this project, so we embarked on learning a new framework and programming language. For many of us, this was our first experience developing a mobile app, providing an opportunity to familiarize ourselves with Apple's code development tools and Xcode. We found the simplicity of the Flutter framework appealing and appreciated its capabilities in enabling us to create such a beautiful mobile app.
## What's next for Fumble
