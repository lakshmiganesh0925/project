# React + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react/README.md) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh


Deploy the website using netlify link of the website (https://usermanagementlist.netlify.app/)

Objective
Develop a simple web application where users can view, add, edit, and delete user details from a mock backend API.
Requirements
User Interface:
---Display a list of users with details such as ID, First Name, Last Name, Email, and Department.
   Provide buttons or links to "Add", "Edit", and "Delete" users.
   A form to input details of a new user or edit details of an existing user.
Backend Interaction:
   Use JSONPlaceholder, a free online REST API that you can use for demonstration and test purposes.
   Specifically, use the '/users' endpoint to fetch and manipulate user data.
Functionality:
   View: Display all users by fetching data from the '/users' endpoint.
   Add: Allow adding a new user by posting to the '/users' endpoint. (Note: JSONPlaceholder won't actually add the user, but will simulate a successful response.)
   Edit: Allow editing an existing user. This should involve fetching the current data for a user, allowing for edits, and then putting the updated data back via the API.
   Delete: Allow users to be deleted, by sending a delete request to the API.
Error Handling:
  Handle scenarios where the API request might fail - show an error message to the user in such cases.
  Bonus (Optional):
  Implement pagination or infinite scrolling for the user list.
  Add client-side validation for the user input form.
  Make the interface responsive.


To work in project using JSONPlaceholder API  https://jsonplaceholder.typicode.com/users 
Using AXIOS  a library used to create HTTP requests to external resources. Preform operations like Get, Post, Update, Delete data in the project 

The developed link  https://project-ufw9.onrender.com  ![Screenshot 2025-01-28 114750](https://github.com/user-attachments/assets/3a1a95d6-ee29-40bd-bfa9-e2751e5f2b6a)
