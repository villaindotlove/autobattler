using Godot;

public partial class ComponentManager : Node
{
    private IAutomaton _parent; 
    private Timer _clock;

    public IAutomaton GetParentUnit()
    {
        return _parent;
    }
}


