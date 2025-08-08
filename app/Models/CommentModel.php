<?php
namespace App\Models;

use Database;

class CommentModel {
    private $db;

    public function __construct() {
        $this->db = Database::getInstance()->getConnection();
    }

    /**
     * Gets all comments with user information for the admin panel.
     * @return array
     */
    public function getAllCommentsWithUsers() {
        try {
            $sql = "SELECT c.*, u.email 
                    FROM comments c 
                    JOIN users u ON c.user_id = u.id 
                    ORDER BY c.created_at DESC";
            $stmt = $this->db->query($sql);
            return $stmt->fetchAll();
        } catch (\PDOException $e) {
            return [];
        }
    }

    /**
     * Updates the status of a comment (e.g., 'pending' to 'approved').
     * @param int $id The ID of the comment.
     * @param string $status The new status.
     * @return bool
     */
    public function updateStatus($id, $status) {
        try {
            $stmt = $this->db->prepare("UPDATE comments SET status = ? WHERE id = ?");
            return $stmt->execute([$status, $id]);
        } catch (\PDOException $e) {
            return false;
        }
    }

    /**
     * Deletes a comment by its ID.
     * @param int $id The ID of the comment to delete.
     * @return bool
     */
    public function deleteById($id) {
        try {
            $stmt = $this->db->prepare("DELETE FROM comments WHERE id = ?");
            return $stmt->execute([$id]);
        } catch (\PDOException $e) {
            return false;
        }
    }
}