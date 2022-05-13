# task

FIGMA DESIGN:
https://www.figma.com/file/GaB7Z4toFl647xSIpN8ftF/w42-assessment

The cards on the design are classified into 3 types, viz. Preference Card, Goal Card and Assumptions Card. 

ANIMATIONS:
https://drive.google.com/drive/folders/1G9_7ls0hj2vKnothZU-QT8eCeCtjlLzT

API INTERACTIONS:
To build this screen, you will have to make GET request on two different APIs.

The /mirt-amount API is supposed to build the top section of the screen (MIRT Section) containing the Expected Monthly Income. Since this API will take a while to respond, you have to show an animation.

The /preference-details API is supposed to build rest of the screen containing the Preference Cards, Goal Cards and the Assumption Card. While the API takes time to populate data, the screen should show a Shimmer effect (like Facebook does).

The request to both the APIs has to be parallel and not blocking.

The API endpoints will be provided to you separately.

CODEBASE:
You are expected to use MVVM Architecture. Separate folders of the same have been made in the codebase. 
Please use provider for state management.
For animating the MIRT section of the screen you can use the Lottie package.