(
	local Duplicate = function Duplicate =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				if (subObjectLevel > 3) do
				(
					$.Edit_Poly.ButtonOp #CloneFace;
				)
			)

			#EditablePoly: 
			(
				if (subObjectLevel > 3) do
				(
					local faces = polyOp.GetFaceSelection $;

					polyOp.DetachFaces $ faces delete:false asNode:false;
					polyOp.SetFaceSelection $ ((polyOp.GetFaceSelection $) - faces);
				)
			)

			#Selection:
			(
				local duplicates = #();

				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : Append duplicates (Instance node);
						false : Append duplicates (Copy node);
					)
				)

				select duplicates;
			)
		)
	)

	Macro.Duplicate = Duplicate;
)