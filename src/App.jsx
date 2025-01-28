import React, { useEffect, useState } from "react";
import Form from "./components/Form";
import UserTable from "./components/UserTable";
import Loader from "./components/Loader";
import ErrorBoundary from "./components/ErrorBoundary";
import axios from "axios";

const App = () => {
  const [users, setUsers] = useState([]);
  const [formData, setFormData] = useState({
    id: "",
    name:"",
    email: "",
    username: "",
  });
  const [isEditing, setIsEditing] = useState(false);
  const [loading, setLoading] = useState(true);
  const API_URL = "https://jsonplaceholder.typicode.com/users";

  // Fetch users
  const fetchUsers = async () => {
    try {
      setLoading(true);
      const response = await axios.get(API_URL);
      setUsers(response.data);
    } catch (error) {
      console.error("Error fetching users:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleAddUser = async (user) => {
    try {
      const response = await axios.post(API_URL, user);
      const newUser = {
        ...response.data,
        id: users.length + 1, 
      };
      alert("User added successfully!");
      setUsers([...users, newUser]); 
    } catch (error) {
      console.error("Error adding user:", error);
    }
  };
  

  const handleUpdateUser = async (updatedUser) => {
    try {
      await axios.put(`${API_URL}/${updatedUser.id}`, updatedUser);
      alert("User updated successfully!");
      setUsers(
        users.map((user) =>
          user.id === updatedUser.id
            ? { ...user, ...updatedUser }
            : user
        )
      );
    } catch (error) {
      console.error("Error updating user:", error);
    }
  };

  const handleDeleteUser = async (id) => {
    try {
      await axios.delete(`${API_URL}/${id}`);
      alert("User deleted successfully!");
      setUsers(users.filter((user) => user.id !== id));
    } catch (error) {
      console.error("Error deleting user:", error);
    }
  };

  return (
    <ErrorBoundary>
      <div className="container mx-auto p-4">
        <h1 className="text-3xl font-bold mb-6 text-center">User Management</h1>
        <Form
          formData={formData}
          setFormData={setFormData}
          isEditing={isEditing}
          setIsEditing={setIsEditing}
          onAddUser={handleAddUser}
          onUpdateUser={handleUpdateUser}
        />
        {loading ? (
          <Loader />
        ) : (
          <UserTable
            users={users}
            setFormData={setFormData}
            setIsEditing={setIsEditing}
            onDeleteUser={handleDeleteUser}
          />
        )}
      </div>
    </ErrorBoundary>
  );
};

export default App;
