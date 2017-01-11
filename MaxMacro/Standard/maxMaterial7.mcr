macroScript MaxMaterial7 category:"Max Core" buttonText:"Material ID-7" toolTip:"Material ID-7"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.SetOperation #SetMaterial;
			$.Edit_Poly.MaterialIDToSet = 6;
		)

		#EditablePoly: 
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceMatID $ faces 7;
		)

		#Selection:
		(
			if (SuperClassOf MeditMaterials[7] != textureMap) do
			(
				for node in selection do
				(
					case (Core.Node.IsInstance node) of
					(
						true  : InstanceMgr.SetMtlOnInstances node MeditMaterials[7]; 
						false : node.Material = MeditMaterials[7];
					)
				)
			)
		)
	)
)