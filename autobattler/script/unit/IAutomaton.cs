using Godot;

public interface IAutomaton
{
    [Signal]
    delegate void HpChangedEventHandler(float newHp);
    [Signal]
    delegate void ManaChangedEventHandler(float newMana);
    [Signal]
    delegate void DamagedEventHandler(float damageValue);
    [Signal]
    delegate void DiedEventHandler();
    [Signal]
    delegate void CurrentTileChangedEventHandler(Tile newTile);

    public float CurrentHealth { get; set; }
    public float CurrentMana { get; set; }
    public int TeamColour { get; set; }
    // public Properties Attributes;
    public Tile CurrentTile { get; set; }
    public IAutomaton Target { get; set; } 
    public int ManaIncrement { get; protected set; }

    public float GetSpeed();
    public float GetAttackRange();
}
