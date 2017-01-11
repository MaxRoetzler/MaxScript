macroScript MaxMaterial8 category:"Max Core" buttonText:"Material ID-8" toolTip:"Material ID-8"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 7;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 8;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[8] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[8]; 
						false : node.Material = MeditMaterials[8];
					)
				)
			)
		)
	)
)