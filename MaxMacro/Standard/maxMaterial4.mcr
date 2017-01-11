macroScript MaxMaterial4 category:"Max Core" buttonText:"Material ID-4" toolTip:"Material ID-4"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 3;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 4;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[4] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[4]; 
						false : node.Material = MeditMaterials[4];
					)
				)
			)
		)
	)
)