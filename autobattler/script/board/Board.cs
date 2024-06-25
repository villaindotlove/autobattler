using System.Collections.Generic;
using Godot;

public partial class Board : Node
{
    public Camera3D Camera;
    public Vector2I Dimensions;
    public Vector2 TileSize;
    public Dictionary<Vector2I, Tile> Tiles;
    public Dictionary<Tile, IAutomaton> UnitLocations;

    public Board(Vector2I dimensions, Vector2 tileSize)
    {
        Dimensions = dimensions;
        TileSize = tileSize;
        Tiles = new();
        UnitLocations = new();
    }
}
