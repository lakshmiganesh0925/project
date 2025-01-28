import React from "react";
import TableRow from "./TableRow";

const UserTable = ({ users, setFormData, setIsEditing, onDeleteUser }) => {
  const handleEditUser = (user) => {
    setIsEditing(true);
    setFormData({
      id: user.id,
      name:user.name,
      email: user.email,
      username: user.username
    });
  };

  return (
    <div className="overflow-x-auto">
      <h2 className="text-xl font-semibold mb-4">User List</h2>
      <table className="min-w-full border-collapse border border-gray-300">
        <thead>
          <tr>
            <th className="border border-gray-300 px-4 py-2">ID</th>
            <th className="border border-gray-300 px-4 py-2">Name</th>
            <th className="border border-gray-300 px-4 py-2">Email</th>
            <th className="border border-gray-300 px-4 py-2">UserName</th>
            <th className="border border-gray-300 px-4 py-2">Action</th>
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <TableRow
              key={user.id}
              user={user}
              onEditUser={handleEditUser}
              onDeleteUser={onDeleteUser}
            />
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UserTable;
