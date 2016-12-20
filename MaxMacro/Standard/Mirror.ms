(
	local Mirror = function Mirror =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditablePoly:
			(
				with Redraw off
				(
					local matrix = Matrix3 1;
					local axis = toolmode.AxisConstraints;
					local faces = Core.Poly.GetSelectionAsFace $;
					local verts = Core.Poly.GetSelectionAsVertex $;

					case (GetRefCoordSys ()) of
					(
						#Local	: matrix = Core.Poly.GetSelectionMatrix $ verts:verts faces:faces;
						#Hybrid	: matrix.Row4 = Core.Poly.CalculateWeightedCenter $ verts:verts;
					)

					if (subObjectLevel > 3 and axis == #X or axis == #Y or axis == #Z) do
					(
						polyOp.FlipNormals $ faces;
					)

					Core.Poly.Transfer $ (Core.Util.GetMirrorMatrix ()) matrix verts:verts;
				)

				CompleteRedraw ();
			)

			#EditableLine: 
			(
				with Redraw off
				(
					local knots = #();
					local matrix = Matrix3 1;
					local coords = Core.Util.GetMirrorMatrix ();

					for spline = 1 to (NumSplines $) do
					(
						knots = Core.Line.GetSelectionAsKnot $ spline;
						Core.Line.Transfer $ spline coords matrix knots:knots;
					)

					UpdateShape $;
				)

				CompleteRedraw ();
			)

			#Selection:
			(
				local coords = Matrix3 1;
				local matrix = Matrix3 1;
				local mirror = Core.Util.GetMirrorMatrix ();

				for node in selection do
				(
					if (node.Parent == undefined or FindItem (selection as Array) node.Parent == 0) do
					(
						matrix = node.Transform;

						if (GetRefCoordSys () == #Local) do
						(
							coords = node.Transform;
						)

						case (GetCoordCenter ()) of
						(
							#Local		:  coords.Row4 = node.pos;
							#Selection	:  coords.Row4 = selection.Center;
						)

						node.Transform = (matrix * Inverse coords) * mirror * coords;
					)
				)
			)
		)
	)

	Macro.Mirror = Mirror;
)