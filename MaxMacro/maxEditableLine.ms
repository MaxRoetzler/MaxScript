(
	struct maxEditableLine
	(

----------------------
-- NODE | OPERATION --
----------------------

		public function Attach node =
		(
			SplineOps.StartAttach node;
		),

----------------------------
-- SUB-OBJECT | SELECTION --
----------------------------

		public function SelectGrow node =
		(
			case subObjectLevel of
			(
				1 : for i = 1 to (NumSplines node) do SetKnotSelection node i (Core.Line.GrowKnotSelection node i);
				2 : for i = 1 to (NumSplines node) do SetSegSelection node i (Core.Line.GrowSegmentSelection node i);
			)
		),

		public function SelectShrink node =
		(
			case subObjectLevel of
			(
				1 : for i = 1 to (NumSplines node) do SetKnotSelection node i (Core.Line.ShrinkKnotSelection node i);
				2 : for i = 1 to (NumSplines node) do SetSegSelection node i (Core.Line.ShrinkSegmentSelection node i);
			)
		),

		public function ConvertToKnot node =
		(
			for spline = 1 to (NumSplines node) do
			(
				SetKnotSelection node spline (Core.Line.GetSelectionAsKnot node spline);
			)

			subObjectLevel = 1;
		),

		public function ConvertToSegment node =
		(
			for spline = 1 to (NumSplines node) do
			(
				SetSegSelection node spline (Core.Line.GetSelectionAsSegment node spline);
			)

			subObjectLevel = 2;
		),

		public function ConvertToSpline node =
		(
			case subObjectLevel of
			(
				1 : (SetSplineSelection node (for i = 1 to (NumSplines node) where (Core.Line.HasKnotSelection node i) collect i));
				2 : (SetSplineSelection node (for i = 1 to (NumSplines node) where (Core.Line.HasSegmentSelection node i) collect i));
			)

			subObjectLevel = 3;
		),

----------------------------
-- SUB-OBJECT | OPERATION --
----------------------------

		public function Fillet node =
		(
			SplineOps.StartFillet node;
		),

		public function Break node =
		(
			SplineOps.StartBreak node;
		),

		public function Chamfer node =
		(
			SplineOps.StartChamfer node;
		),

		public function Close node =
		(
			SplineOps.Close node;
		),

		public function Collapse node =
		(
			SplineOps.Fuse node;
			WeldSpline node 1e-3;
		),

		public function Connect node =
		(
			if (subObjectLevel == 1) do
			(
				local count = 0;
				local knots = #();
				local total = NumSplines node;

				for spline = 1 to total do
				(
					for knot in (GetKnotSelection node spline) while (count < 3) do
					(
						Append knots (GetKnotPoint node spline knot);
						count += 1;
					)
				) -- End collect selected knots.

				if (count == 2) do
				(
					local index = total + 1;

					AddNewSpline node;

					AddKnot node index #Smooth #Curve knots[1];
					AddKnot node index #Smooth #Curve knots[2];

					UpdateShape node;
					CompleteRedraw ();
				)
			)
		),

		public function Create node =
		(
			SplineOps.StartCreateLine node;
		),

		public function Cut node =
		(
			SplineOps.StartRefine node;
		),

		public function Detach node =
		(
			SplineOps.Detach node;
		),

		public function Divide node =
		(
			SplineOps.Divide node;
		),

		public function Duplicate node =
		(
			print "Not Yet Implemented";
		),

		public function Flatten node =
		(
			with Redraw off
			(
				local knots = #();
				local matrix = Matrix3 1;
				local coords = Core.Util.GetFlattenMatrix ();

				for spline = 1 to (NumSplines node) do
				(
					knots = Core.Line.GetSelectionAsKnot node spline;
					Core.Line.Transfer node spline coords matrix knots:knots;
				)

				UpdateShape node;
			)

			CompleteRedraw ();
		),

		public function Mirror node =
		(
			with Redraw off
			(
				local knots = #();
				local matrix = Matrix3 1;
				local coords = Core.Util.GetMirrorMatrix ();

				for spline = 1 to (NumSplines node) do
				(
					knots = Core.Line.GetSelectionAsKnot node spline;
					Core.Line.Transfer node spline coords matrix knots:knots;
				)

				UpdateShape node;
			)

			CompleteRedraw ();
		),

		public function Outline node =
		(
			SplineOps.StartOutline node;
		),

		public function Remove node =
		(
			SplineOps.Delete node;
		),

		public function Smooth node id =
		(
			with redraw off
			(
				local knots;
				local type;

				case id of
				(
					0 : type = #Corner;
					1 : type = #Smooth;
					2 : type = #Bezier;
					3 : type = #BezierCorner;
				)

				for spline = 1 to (NumSplines node) do
				(
					knots = Core.Line.GetSelectionAsKnot node spline;

					for knot in knots do
					(
						SetKnotType node spline knot type;
					)
				)
			)

			UpdateShape node;
			CompleteRedraw ();
		),

		public function Weld node =
		(
			WeldSpline node 1e-4;
		)
	)

	Macro.ELine = maxEditableLine;
)