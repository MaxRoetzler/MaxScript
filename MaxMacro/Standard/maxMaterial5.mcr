macroScript MaxMaterial5 category:"Max Core" buttonText:"Material ID-5" toolTip:"Material ID-5"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 4;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 5;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[5] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[5]; 
						false : node.Material = MeditMaterials[5];
					)
				)
			)
		)
	)
)