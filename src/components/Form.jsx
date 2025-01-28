import React from "react";

const Form = ({ formData, setFormData, isEditing, setIsEditing, onAddUser, onUpdateUser }) => {
  const handleInputChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (isEditing) {
      onUpdateUser(formData);
    } else {
      onAddUser(formData);
    }
    setFormData({ id: "", name: "", email: "", username: "" });
    setIsEditing(false);
  };

  return (
    <form className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-6" onSubmit={handleSubmit}>
      <div className="mb-4">
        <input
          className="w-full px-3 py-2 border rounded-lg focus:outline-none"
          type="text"
          name="name"
          placeholder="Full Name"
          value={formData.name}
          onChange={handleInputChange}
          required
        />
      </div>
      <div className="mb-4">
        <input
          className="w-full px-3 py-2 border rounded-lg focus:outline-none"
          type="email"
          name="email"
          placeholder="Email"
          value={formData.email}
          onChange={handleInputChange}
          required
        />
      </div>
      <div className="mb-4">
        <input
          className="w-full px-3 py-2 border rounded-lg focus:outline-none"
          type="text"
          name="username"
          placeholder="Username"
          value={formData.username}
          onChange={handleInputChange}
        />
      </div>
      <button
        type="submit"
        className="w-full bg-blue-500 text-white py-2 rounded-lg hover:bg-blue-600"
      >
        {isEditing ? "Update User" : "Add User"}
      </button>
    </form>
  );
};

export default Form;
