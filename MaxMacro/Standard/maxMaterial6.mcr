macroScript MaxMaterial6 category:"Max Core" buttonText:"Material ID-6" toolTip:"Material ID-6"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 5;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 6;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[6] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[6]; 
						false : node.Material = MeditMaterials[6];
					)
				)
			)
		)
	)
)