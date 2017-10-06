/*
	Align grid when Viewport changes ? register callback when toggle is ON

	Change world - coordsys to grid, when grid is active

	Move to grid (move all objects, vertices etc to grid 0, based on tool axis)

	Implement auto-align callback
*/

(
	struct maxGrid
	(
		private m_node = undefined,
		private m_state = false,
		private m_autoAlign = false,

		private function GetNode =
		(
			case (IsValidNode $MaxGrid) of
			(
				true  : m_node = $MaxGrid;
				false : m_node = Grid length:100 width:100 grid:10 name:"MaxGrid";
			)

			m_node.IsFrozen = true;
			ActiveGrid = m_node;
		),

		public function Toggle =
		(
			GetNode ();

			Viewport.SetGridVisibility #all false;

			m_state = not m_state;
			m_node.IsHidden = m_state;
		),

		public function SetSize size grid =
		(
			GetNode ();

			m_node.length = size;
			m_node.width = size;
			m_node.grid = grid;
		),

		public function AlignToWorld =
		(
			GetNode ();

			m_node.transform = Matrix3 1;
		),

		public function AlignToMatrix matrix =
		(
			GetNode ();

			m_node.transform = matrix;
		),

		public function AlignToView =
		(
			GetNode ();

			m_node.transform = Core.Util.AlignMatrixToView ();
		),

		public function AlignToScreen =
		(
			GetNode ();

			m_node.dir = Core.Util.GetViewVector ();
		),

		public function OnEnable =
		(
			GetNode ();

			Viewport.SetGridVisibility #all false;
		),

		public function OnDisable =
		(
			if (IsValidNode m_node) do
			(
				Delete m_node;
				m_node = undefined;
			)
		)
	)

	-- Register to core
	Core.Grid = maxGrid ();
)