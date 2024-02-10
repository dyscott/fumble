# Fumble

Fumble addresses the challenge CS students face in finding reliable project collaborators by facilitating connections through a matching platform and fostering meaningful communication with a seamless messaging feature. Users can sign up via email or Discord, swipe through profiles for potential matches, and utilize profile editing tools to customize their information, enhancing the collaborative experience in educational projects.

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
go run .
```
## How we Built it
### Frontend

For the frontend of Fumble, we utilized Flutter as our primary framework. Flutter is an open-source UI software development toolkit based on Dart. We used its rich set of pre-built widgets and tools to develop an intuitive and high-performing mobile app. The user can seamlessly sign up or log into a Fumble profile using their Discord or email credentials. After signing in or logging in, users have the option to add/edit their name, biography and to pick which courses they are seeking partners for.

To host the app on mobile devices, we utilize Xcode and Apple Developer tools on iPhones.

### Backend

## Challenges we ran into

For this project, we navigated languages, frameworks, and development tools that were entirely unfamiliar to us at the beginning of the hackathon. We had to figure out how to integrate the different part of our mobile app development, which involved four users, into one cohesive product. By using branches and separating various pages and components of the project, we overcame these challenges and effectively developed Fumble.

## Accomplishments that we're proud of
For many on our team, this was our first experience creating a mobile app, and we are grateful for the opportunity to do so. We are also proud to have developed an app that facilitates socialization and collaboration for CS majors, helping combat the challenges associated with such a difficult major.

## What we learned

The entire team was unfamiliar with Flutter before starting this project, so we embarked on learning a new framework and programming language. For many of us, this was our first experience developing a mobile app, providing an opportunity to familiarize ourselves with Apple's code development tools and Xcode. We found the simplicity of the Flutter framework appealing and appreciated its capabilities in enabling us to create such a beautiful mobile app.

## What's next for Fumble

While we are satisfied with how Fumble came out, we recognize the potential for enhancements to elevate it even further. Our next steps include integrating a feedback form directly within the app. This will enable us to seamlessly gather valuable insights and suggestions from the community, allowing us to refine and optimize Fumble based on user input. Moreover, we envision enhancing the matchmaking algorithm by incorporating machine learning techniques. By training an AI model on user interactions—such as swipes to the right or left—we aim to make Fumble's matching system more intuitive and tailored to individual preferences. These improvements represent our commitment to continuous refinement, ensuring Fumble remains a dynamic and user-centric platform.

