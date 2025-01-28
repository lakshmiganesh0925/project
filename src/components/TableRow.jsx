import React from "react";

const TableRow = ({ user, onEditUser, onDeleteUser }) => {
  return (
    <tr>
      <td className="border border-gray-300 px-4 py-2">{user.id}</td>
      <td className="border border-gray-300 px-4 py-2">{user.name}</td>
      <td className="border border-gray-300 px-4 py-2">{user.email}</td>
      <td className="border border-gray-300 px-4 py-2">{user.username}</td>
      <td className="border border-gray-300 px-4 py-2">
        <button
          className="bg-yellow-500 text-white px-3 py-1 rounded mr-2 hover:bg-yellow-600"
          onClick={() => onEditUser(user)}
        >
          Edit
        </button>
        <button
          className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
          onClick={() => onDeleteUser(user.id)}
        >
          Delete
        </button>
      </td>
    </tr>
  );
};

export default TableRow;
