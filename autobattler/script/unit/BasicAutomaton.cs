using Godot;

public partial class BasicAutomaton : Node3D, IAutomaton
{
    public float CurrentHealth { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }
    public float CurrentMana { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }
    public int TeamColour { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }
    public Tile CurrentTile { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }
    public IAutomaton Target { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }
    int IAutomaton.ManaIncrement { get => throw new System.NotImplementedException(); set => throw new System.NotImplementedException(); }

    public float GetAttackRange()
    {
        throw new System.NotImplementedException();
    }

    public float GetSpeed()
    {
        throw new System.NotImplementedException();
    }
}