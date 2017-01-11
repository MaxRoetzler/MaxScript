macroScript MaxFlatten category:"Max Core" buttonText:"Flatten" toolTip:"Flatten"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditablePoly: 
		(
			with Redraw off
			(
				local matrix = Matrix3 1;
				local verts = Core.Poly.GetSelectionAsVertex $;

				case (GetRefCoordSys ()) of
				(
					#Local	: matrix = Core.Poly.GetSelectionMatrix $;
					#Hybrid	: matrix.Row4 = Core.Poly.CalculateWeightedCenter $ verts:verts;
				)

				Core.Poly.Transfer $ (Core.Util.GetFlattenMatrix ()) matrix;
			)

			CompleteRedraw ();
		)

		#EditableLine:
		(
			with Redraw off
			(
				local knots = #();
				local matrix = Matrix3 1;
				local coords = Core.Util.GetFlattenMatrix ();

				for spline = 1 to (NumSplines $) do
				(
					knots = Core.Line.GetSelectionAsKnot $ spline;
					Core.Line.Transfer $ spline coords matrix knots:knots;
				)

				UpdateShape $;
			)

			CompleteRedraw ();
		)

		#Unwrap_UVW:
		(
			$.Unwrap_Uvw.flattenMapNoParams ();
		)
	)
)