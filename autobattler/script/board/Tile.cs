using System.Collections.Generic;
using Godot;

public partial class Tile : MeshInstance3D
{
    public Vector2I Coordinate;
    private bool _occupied = false;
    private List<Tile> _neighbours;
    private Material _occupiedMaterial;
    private Material _unoccupiedMaterial;

    public override void _Process(double delta)
    {
        if (_occupied)
        {
            SetSurfaceOverrideMaterial(0, _occupiedMaterial);
        }
        else
        {
            SetSurfaceOverrideMaterial(0, _unoccupiedMaterial);
        }
    }

    public void SetTileDimensions(Vector3 newDimensions)
    {
        var mesh = (BoxMesh)Mesh;
        mesh.Size = newDimensions;
    }

    public bool IsOccupied()
    {
        return _occupied;
    }

    public List<Tile> GetNeighbours()
    {
        return _neighbours;
    }

    public override string ToString()
    {
        return Coordinate.ToString();
    }
}
