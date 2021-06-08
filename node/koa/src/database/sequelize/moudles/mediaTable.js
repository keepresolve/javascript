/* jshint indent: 2 */

const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('mediaTable', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    Media_type: {
      type: DataTypes.STRING(64),
      allowNull: false
    },
    Media_id: {
      type: DataTypes.STRING(225),
      allowNull: false,
      unique: "Media_id"
    },
    MusicUrl: {
      type: DataTypes.STRING(225),
      allowNull: true
    },
    HQMusicUrl: {
      type: DataTypes.STRING(225),
      allowNull: true
    },
    title: {
      type: DataTypes.STRING(128),
      allowNull: true
    },
    content: {
      type: DataTypes.STRING(225),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'mediaTable',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "Media_id",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "Media_id" },
        ]
      },
    ]
  });
};
