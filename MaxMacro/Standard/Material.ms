(
	local Material = function Material id =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				if (id > 0) do
				(
					$.Edit_Poly.SetOperation #SetMaterial;
					$.Edit_Poly.MaterialIDToSet = id;
				)
			)

			#EditablePoly: 
			(
				if (id > 0) do
				(
					local faces = Core.Poly.GetSelectionAsFace $;
					polyOp.SetFaceMatID $ faces id;
				)
			)

			#Selection:
			(
				if (id > 0) then
				(
					if (SuperClassOf MeditMaterials[id] != textureMap) do
					(
						for node in selection do
						(
							case (Core.Node.IsInstance node) of
							(
								true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[id]; 
								false : node.material = MeditMaterials[id];
							)
						)
					)
				)
				else for node in selection do node.Material = undefined;
			)
		)
	)

	Macro.Material = Material;
)