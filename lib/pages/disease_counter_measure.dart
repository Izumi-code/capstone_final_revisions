import 'package:flutter/material.dart';

class DiseaseCountermeasurePage extends StatelessWidget {
  final String detectedDiseaseClassName;

  DiseaseCountermeasurePage({required this.detectedDiseaseClassName});

  @override
  Widget build(BuildContext context) {
    // Implement countermeasures based on the detected pest class name
    String countermeasures = getCountermeasures(detectedDiseaseClassName);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Countermeasures'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detected Disease: $detectedDiseaseClassName',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Countermeasures:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                countermeasures,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getCountermeasures(String detectedDiseaseClassName) {
    // Trim leading and trailing whitespaces
    detectedDiseaseClassName = detectedDiseaseClassName.trim().toLowerCase();

    switch (detectedDiseaseClassName) {
      case 'bacterialblight':
        return '''
What it does:
Bacterial blight is caused by Xanthomonas oryzae pv. oryzae. 

It causes wilting of seedlings and yellowing and drying of leaves.

Why and where it occurs:
The disease is most likely to develop in areas that have weeds and stubbles of infected plants. It can occur in both tropical and temperate environments, particularly in irrigated and rainfed lowland areas. In general, the disease favors temperatures at 25−34°C, with relative humidity above 70%.

It is commonly observed when strong winds and continuous heavy rains occur, allowing the disease-causing bacteria to easily spread through ooze droplets on lesions of infected plants.

Bacterial blight can be severe in susceptible rice varieties under high nitrogen fertilization.

How to identify:
Check for wilting and yellowing of leaves, or wilting of seedlings (also called kresek).

On seedlings, infected leaves turn grayish green and roll up. As the disease progresses, the leaves turn yellow to straw-colored and wilt, leading whole seedlings to dry up and die.

Kresek on seedlings may sometimes be confused with early rice stem borer damage. 

To distinguish kresek symptoms from stem borer damage, squeeze the lower end of infected seedlings between the fingers. Kresek symptoms should show yellowish bacterial ooze coming out of the cut ends. Unlike plants infested with stem borer, rice plants with kresek are not easily pulled out from soil.

Check for lesions:
On older plants, lesions usually develop as water-soaked to yellow-orange stripes on leaf blades or leaf tips or on mechanically injured parts of leaves. Lesions have a wavy margin and progress toward the leaf base.

On young lesions, bacterial ooze resembling a milky dew drop can be observed early in the morning. The bacterial ooze later on dries up and becomes small yellowish beads underneath the leaf.

Old lesions turn yellow to grayish white with black dots due to the growth of various saprophytic fungi. On severely infected leaves, lesions may extend to the leaf sheath.

To quickly diagnose bacterial blight on leaf:

cut a young lesion across and place in a transparent glass container with clear water

after a few minutes, hold the container against light and observe for thick or turbid liquid coming from the cut end of the leaf
Countermeasures for bacterial blight.
Why is it important:
Bacterial blight is one of the most serious diseases of rice. The earlier the disease occurs, the higher the yield loss.

Yield loss due to bacterial blight can be as much as 70% when susceptible varieties are grown, in environments favorable to the disease.

When plants are infected at booting stage, bacterial blight does not affect yield but results in poor quality grains and a high proportion of broken kernels.

How to manage:
Planting resistant varieties has been proven to be the most efficient, most reliable, and cheapest way to control bacterial blight.

Other disease control options include:

Use balanced amounts of plant nutrients, especially nitrogen.

Ensure good drainage of fields (in conventionally flooded crops) and nurseries.

Keep fields clean. Remove weed hosts and plow under rice stubble, straw, rice ratoons and volunteer seedlings, which can serve as hosts of bacteria.

Allow fallow fields to dry in order to suppress disease agents in the soil and plant residues.

Source: http://www.knowledgebank.irri.org/decision-tools/rice-doctor/rice-doctor-fact-sheets/item/bacterial-blight?fbclid=IwAR09is0EIRizsqJ3jaPS-qmk_WTW9iRiIVjGi7u2J28Ty7vOP1Yc_vdCG9s

''';
      case 'blast':
        return '''
Blast symptoms can occur on leaves, leaf collars, nodes and panicles. Leaf spots are typically elliptical (football shaped), with gray-white centers and brown to red-brown margins (Figure 1). Fully developed leaf lesions are approximately 0.4 to 0.7 inch long and 0.1 to 0.2 inch wide. Both the shape and the color vary depending on the environment, age of the lesion and rice variety. Lesions on leaf sheaths, which rarely develop, resemble those on leaves.

The most serious damage occurs when the fungus attacks nodes just below the head (Figure 2). The stems often break at the diseased node. This stage of the disease is referred to as “rotten neck.” Disease in the node prevents the flow of water and nutrients to the kernels and they will stop developing. Heads of plants damaged in this way may be completely blank (Figure 3) to nearly normal, depending on the stage of head development when infection occurs. The poorly developed grain usually breaks up badly in milling, reducing quality.
Causal agent
This disease is caused by a fungus named Pyricularia grisea, which overwinters in rice seeds and infected rice stubble. The fungus reproductive structures, spores, can spread from these two sources to rice plants during the next growing season and initiate new infections. Spores from these new infections can spread by wind to other rice plants over great distances.

There are several races of Pyricularia grisea. Race 1B49 has been found in Missouri, but it is not yet known if other races are present.

Countermeasures for brice blast.

Control
Use preventive measures:

Incorporate or roll the rice stubble soon after harvest to promote early decomposition.
Plant the least-susceptible varieties and use a broad-spectrum seed treatment.
Grow rice in open fields free of tree lines particularly on east and south sides
Grow rice in fields where flood levels are easily maintained. Damage from blast can be reduced by keeping soil flooded 2 to 4 inches deep from the time rice plants are 6 to 8 inches tall until draining for harvest. Draining for straighthead is incompatible with the flooding required for blast control, so avoid fields with a history of straighthead and varieties susceptible to straighthead, or plant blast-resistant varieties in these fields.
Seed over a range of time to spread the heading dates. However, avoid planting late because blast will be more severe.
Seed to a stand of 15 to 20 plants per square foot.
Avoid excessive nitrogen application rates and apply no more than 30 pounds per acre of nitrogen per application at midseason. In fields with a history of blast, always split applications.

Use fungicides:
Scout fields for blast symptoms from the seedling through heading stages (see Scouting). If symptoms are found, prepare to use fungicides at the late boot stage and again when 80 to 90 percent of plants are headed.

Apply fungicides during the time frame predicted by the DD50 program, which is about 5 to 7 days before heading (late boot stage). Fungicides are especially needed if blast symptoms have been observed in the field and the variety is very susceptible. Fungicides should be applied a second time about two days after 50 percent heading (90 percent head exsertion). In uniform stands, 90 percent heading will occur in 4 to 5 days after the first heads are visible.

The decision to treat is more easily made when one or more of the following factors exist:

A susceptible variety is grown in the field.
The crop has excessive growth and a dense canopy.
Leaf symptoms have been found in the field.
Disease is present in southern parts of the field.
Cool, rainy, or cloudy weather with high humidity and heavy dews is predicted during heading.
The development of this disease is difficult to predict, and fungicide treatments are expensive. Therefore, you should treat on the basis of the above factors or automatically treat the field with a fungicide if you are unwilling to risk disease damage.

Scouting:
Early:
Rice fields should be scouted for leaf symptoms of blast beginning at the seedling stage and continuing until early heading. Leaf symptoms will appear most readily on plants at the edges of fields, on levees, in areas of the fields that are shaded in the morning, or in areas that received excessive nitrogen. Symptoms usually are worse on drought-stressed rice.

If you are uncertain about diagnosing blast symptoms, send a sample to your local MU Extension center for identification. A preboot fungicide application may be needed when foliage damage is severe and the stand is threatened. Proper fertilization and continuous flooding should minimize seedling damage.

Midseason:
You should continue to scout for blast near the heading stage and watch carefully for flagleaf collar symptoms on early-planted susceptible varieties. Also, devote time to determine the stage of rice development to see if the DD50 predicted time frame for fungicide treatment for blast is correct. Symptoms appear 4 to 6 days after infection, so rice heads may be infected without symptoms appearing.

Source: https://extension.missouri.edu/publications/mp645?fbclid=IwAR1kRqDutQ0dEBF-R1hPhdKpjU_yoXbiOS1cXm4flfZyD6wkeZLi07CiS7o#:~:text=Rice%20blast%20can%20be%20controlled,80%20to%2090%20percent%20headed
''';
      case 'brownspot':
        return '''
Brown spot has been historically largely ignored as one of the most common and most damaging rice diseases.

What it does
Brown spot is a fungal disease that infects the coleoptile, leaves, leaf sheath, panicle branches, glumes, and spikelets. 

Its most observable damage is the numerous big spots on the leaves which can kill the whole leaf. When infection occurs in the seed, unfilled grains or spotted or discolored seeds are formed. 

Why and where it occurs
The disease can develop in areas with high relative humidity (86−100%) and temperature between 16 and 36°C. It is common in unflooded and nutrient-deficient soil, or in soils that accumulate toxic substances. 

For infection to occur, the leaves must be wet for 8−24 hours.

The fungus can survive in the seed for more than four years and can spread from plant to plant through air. Major sources of brown spot in the field include:

infected seed, which give rise to infected seedlings
volunteer rice
infected rice debris
weeds
Brown spot can occur at all crop stages, but the infection is most critical during maximum tillering up to the ripening stages of the crop.

How to identify
Check for lesions:

Infected seedlings have small, circular, yellow brown or brown lesions that may girdle the coleoptile and distort primary and secondary leaves.
Starting at tillering stage, lesions can be observed on the leaves. They are initially small, circular, and dark brown to purple-brown.
Fully developed lesions are circular to oval with a light brown to gray center, surrounded by a reddish brown margin caused by the toxin produced by the fungi.
On susceptible varieties, lesions are 5−14 mm long which can cause leaves to wilt. On resistant varieties, the lesions are brown and pinhead-sized.

brown-spot-1	 	brown-spot-4
  Spots and lesions on leaves
Lesions on leaf sheaths are similar to those on the leaves. Infected glumes and panicle branches have dark brown to black oval spots or discoloration on the entire surface.

Spikelets can also be infected. Infection of florets leads to incomplete or disrupted grain filling and a reduction in grain quality. The disease-causing fungi can also penetrate grains, causing 'pecky rice', a term used to describe spotting and discoloration of grains.

In certain rice varieties, brown spot lesions can be mistaken for blast lesions. To confirm, check if spots are circular, brownish, and have a gray center surrounded by a reddish margin.

Why is it important
Brown spot causes both quantity and quality losses. 

On average, the disease causes 5% yield loss across all lowland rice production in South and Southeast Asia. Severely infected field can have as high as 45% yield loss.

Heavily infected seeds cause seedling blight and lead to 10−58% seedling mortality. It also affects the quality and the number of grains per panicle, and reduces the kernel weight.

In terms of history, Brown spot was considered to be the major factor contributing to the Great Bengal Famine in 1943.

Countermeasure:
How to manage
Improving soil fertility is the first step in managing brown spot. To do this:

monitor soil nutrients regularly
apply required fertilizers
for soils that are low in silicon, apply calcium silicate slag before planting
Fertilizers, however, can be costly and may take many cropping seasons before becoming effective. More economical management options include:

Use resistant varieties. 
Contact your local agriculture office for up-to-date lists of varieties available.
Use fungicides (e.g., iprodione, propiconazole, azoxystrobin, trifloxystrobin, and carbendazim) as seed treatments.
Treat seeds with hot water (53−54°C) for 10−12 minutes before planting, to control primary infection at the seedling stage. To increase effectiveness of treatment, pre-soak seeds in cold water for eight hours.

Source: http://www.knowledgebank.irri.org/training/fact-sheets/pest-management/diseases/item/brown-spot#:~:text=Brown%20spot%20is%20a%20fungal,or%20discolored%20seeds%20are%20formed.
''';
//       case 'rice-bug':
//         return '''
// What it does?factsheet-black-bug
// Black bugs remove the sap of the plant. They can cause browning of leaves, deadheart, and bugburn. Their damage also causes stunting in plants, reduced tiller number, and formation of whiteheads.

// On severe cases, black bugs weaken the plant preventing them from producing seeds.

// Why and where it occurs
// The insect is common in rainfed and irrigated wetland environments. It prefers continuously cropped irrigated rice areas and poorly drained fields. Damages are observed more frequently in dry season rice crops and densely planted fields.

// Black bug flight patterns are affected by the lunar cycle; on full moon nights, large numbers of adults swarm to light sources.

// Staggered planting of the rice crop and excessive nitrogen also favor the buildup of the pest. During non-rice periods, the presence of alternate breeding site favors population increase.

// How to identify
// Check leaves for discoloration. Black bug damage can cause reddish brown or yellowing of plants. Leaves also have chlorotic lesions.
// Check for decreased tillering. Bugburn symptoms show wilting of tillers with no visible honeydew deposits or sooty molds.
// Plants are also stunted; and can develop stunted panicles, no panicles, incompletely exerted panicles, and unfilled spikelets or whiteheads at booting stage.
// Check for deadhearts.
// black-bug-1

// Deadhearts can also be caused by stemborer. To confirm cause of damage, pull infected plants. In black bug damage, infected plants cannot be pulled at the bases.

// Heavy infestation and "bugburn" is usually visible after heading or maturing.

// Why is it important
// Black bug feeds on the rice plant from seedling to maturity growth stages. Ten black bug adults per hill can cause losses of up to 35% in some rice.

// How to manage
// To prevent black bug infestation:

// Use resistant varieties.
// Contact your local agriculture office for up-to-date lists of varieties available.
// Maintain a clean field by removing the weeds and drying the rice field after plowing.
// Plant rice varieties of the same maturity date to break the insect’s cycle.
// Use of mercury bulbs as light traps for egg-laying adults, light trapping of insects should start 5 days before and after the full moon.
// Encourage biological control agents, such as small wasps (parasitize the eggs), ground beetles, spiders, crickets, and red ants (attack the eggs, nymphs, and adults), coccinellid beetles, ducks, toads (feed on eggs and nymphs), fungi species (attacks nymphs and adults).
// To control black bug infestation:

// During early infestation, raise the water level in the field for 2−3 days to force the insects to move upwards.
// Flood the fields. This can cause higher egg mortality.
// After harvest, plow fields to remove remaining insects.
// ''';
//       case 'stem-borer':
//         return '''
// What it does:
// Stem borers can destroy rice at any stage of the plant from seedling to maturity.

// They feed upon tillers and causes deadhearts or drying of the central tiller, during vegetative stage; and causes whiteheads at reproductive stage.

// Why and where it occurs:
// The stem borer larvae bore at the base of the plants during the vegetative stage. On older plants, they bore through the upper nodes and feed toward the base.

// The yellow stem borer is a pest of deepwater rice. It is found in aquatic environments where there is continuous flooding. Second instar larvae enclose themselves in body leaf wrappings to make tubes and detach themselves from the leaf and falls onto the water surface. They attach themselves to the tiller and bore into the stem.

// How to identify
// Check the field for the following damage symptoms:

// Deadhearts or dead tillers that can be easily pulled from the base during the vegetative stages
// Whiteheads during reproductive stage where the emerging panicles are whitish and unfilled or empty
// Tiny holes on the stems and tillers
// Frass or fecal matters inside the damaged stems
// Deadhearts and whiteheads symptoms may sometimes be confused with damages caused by rats, neck blast, and black bug diseases.

// To confirm stem borer damage, visually inspect rice crop for deadhearts in the vegetative stages and whiteheads in reproductive stages. Stems can be pulled and dissected for larvae and pupae for confirmation of stem borer damage.

// Countermeasures for yellow stemborer.

// Why is it important
// Excessive boring through the sheath can destroy the crop. Its damage can reduce the number of reproductive tillers. At late infection, plants develop whiteheads.

// Yellow stemborer damage can lead to about 20% yield loss in early planted rice crops, and 80% in late-planted crops.
// White stemborer is an important pest in rainfed wetland rice. It can cause outbreaks and destroy rice fields.
// Striped stemborer is one of the most important insect pests in Asia. Its damage can be as high as 100% when severe.
// Gold-fringed stemborer can cause yield loss of about 30%.

// How to manage
// Use resistant varieties
// At seedbed and transplanting, handpick and destroy egg masses
// Raise level of irrigation water periodically to submerge the eggs deposited on the lower parts of the plant
// Before transplanting, cut the leaf-top to reduce carry-over of eggs from the seedbed to the field
// Ensure proper timing of planting and synchronous planting, harvest crops at ground level to remove the larvae in stubble, remove stubble and volunteer rice, plow and flood the field
// Encourage biological control agents: braconid, eulophid, mymarid, scelionid, chalcid, pteromalid and trichogrammatid wasps, ants, lady beetles, staphylinid beetles, gryllid, green meadow grasshopper, and mirid, phorid and platystomatid flies, bethylid, braconid, elasmid, eulophid, eurytomid and ichneumonid wasps, carabid and lady bird beetles, chloropid fly, gerrid and pentatomid bugs, ants, and mites,  earwigs, bird, asilid fly, vespid wasp, dragonflies, damselflies, and spiders
// Bacteria and fungi also infect the larvae: mermithid nematode, chalcid, elasmid and eulophid
// Apply nitrogen fertilizer in split following the recommended rate and time of application.

// Source: http://www.knowledgebank.irri.org/training/fact-sheets/pest-management/insects/item/planthopper?fbclid=IwAR0PRmfxznU2Y3zZ7irQeVk4Pko9OdO8-WGibXjxeZyu8PbPbKyv_RYL6Bs

// ''';
//       case 'whorl-maggot':
//         return '''
// What it does
// The feeding damage of whorl maggots causes yellow spots, white or transparent patches, and pinholes.

// The larva uses its hardened mouth hooks to rasp the tissues of unopened leaves or the growing points of the developing leaves. The damage becomes visible when the leaves grow old. Mature larva prefers to feed on the developing leaves of the new developing tillers at the base of the rice plant.

// Why and where it occurs
// rice-whorl-maggot-1Standing water in paddies during the vegetative stage, presence of host plants year-round, and transplanting of young seedlings favor the development of rice whorl maggot.

// The rice whorl maggot is semi-aquatic. It is common in irrigated fields and feeds on the central whorl leaf of the vegetative stage of the rice plant. It does not occur in upland rice. It also prefers ponds, streams and lakes or places with abundant calm water and lush vegetation.

// The insect does not prefer direct-seeded fields and seedbeds. The adult is active during the day and rests on rice leaves near the water. It floats on the water or perches on floating vegetation. At midday, it is sedentary or it clings on upright vegetation. It prefers thick vegetation and is attracted to open standing water around seedbeds. Neonate maggots feed on the unopened central leaves where larval development is completed in 10−12 days. The full-grown maggots pupate outside the feeding stalk.

// How to identify
// rice-whorl-maggot-damage

// Check the plant for the following symptoms:

// white or transparent patches
// pinholes
// damaged leaves easily break from the wind
// somewhat distorted leaves
// clear or yellow spots on inner margins of emerging leaves
// stunting
// few tillers
// Check for the presence of insects:

// elongate, white eggs glued on leaves
// transparent to light cream legless young larvae rasping the tissues of unopened leaves
// yellow mature larva feeding on developing leaves of the new developing tillers at the base of the rice plant

// Why is it important
// The rice whorl maggot begins to infest the rice plant at transplanting. It locates rice fields by reflected sunlight from the water surface.

// Using insecticides is not recommended for the rice whorl maggot control because the rice plant can compensate for the damage.

// How to manage
// There is no cultural control for rice whorl maggot.

// Small wasps parasitized the eggs and the maggots. Dolicopodid flies prey on the eggs and ephydrid flies and spiders feed on the adults.

// The rice plant can compensate for the damage caused by the rice whorl maggot. Usually, the symptoms disappear during the maximum tillering stage of the crop.
// ''';
      // Add more cases as needed
      default:
        return 'No specific countermeasures available for $detectedDiseaseClassName.';
    }
  }
}
