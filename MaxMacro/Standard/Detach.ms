(
	local Detach = function Detach =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				local name = UniqueName ($.Name + "Part");
				$.Edit_Poly.DetachToObject name;
			)

			#EditablePoly: 
			(
				if (subObjectLevel > 3) do
				(
					local name = UniqueName ($.Name + "Part");
					local faces = polyOp.GetFaceSelection $;

					polyOp.DetachFaces $ faces delete:true asNode:true name:name;
				)
			)

			#EditableLine: 
			(
				SplineOps.Detach $;
			)
		)
	)

	Macro.Detach = Detach;
)