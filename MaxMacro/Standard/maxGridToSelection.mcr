macroScript MaxGridToSelection category:"Max Core" buttonText:"Grid To Selection" toolTip:"Grid To Selection"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditablePoly: 
		(
			Core.Grid.AlignToMatrix (Core.Poly.GetSelectionMatrix $);
		)

		#Selection:
		(
			local normal = Point3 0 0 0;
			local center = Point3 0 0 0;

			for node in selection do
			(
				center += node.pos;
				normal += node.dir;
			)

			local matrix = MatrixFromNormal (Normalize (normal));
			matrix.Row4 = center / selection.count;

			Core.Grid.AlignToMatrix matrix;
		)
	)
)