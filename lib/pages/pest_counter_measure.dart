import 'package:flutter/material.dart';

class CountermeasurePage extends StatelessWidget {
  final String detectedPestClassName;

  CountermeasurePage({required this.detectedPestClassName});

  @override
  Widget build(BuildContext context) {
    // Implement countermeasures based on the detected pest class name
    String countermeasures = getCountermeasures(detectedPestClassName);

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
                'Detected Pest: $detectedPestClassName',
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

  String getCountermeasures(String detectedPestClassName) {
    // Trim leading and trailing whitespaces
    detectedPestClassName = detectedPestClassName.trim().toLowerCase();

    switch (detectedPestClassName) {
      case 'brown-planthopper':
        return '''
What it does:
High population of planthoppers cause leaves to initially turn orange-yellow before becoming brown and dry and this is a condition called hopperburn that kills the plant.

BPH can also transmit Rice Ragged Stunt and Rice Grassy Stunt diseases. Neither disease can be cured.

Why and where it occurs:
Planthoppers can be a problem in rainfed and in irrigated wetland environments. It also occurs in areas with continuous submerged conditions in the field, high shade, and humidity.

Closed canopy of the rice plants, densely seeded crops, excessive use of nitrogen, and early season insecticide spraying also favors insect development.

How to identify:
Check for the presence of insect:

crescent-shaped white eggs inserted into the midrib or leaf sheath
white to brown nymphs
brown or white adults feeding near the base of tillers

Check the field for:
hopperburn or yellowing, browning and drying of plant
ovipositional marks exposing the plant to fungal and bacterial infections
presence of honeydew and sooty molds in the bases of areas infected
plants with ragged stunt or grassy stunt virus disease
Hopperburn is similar to the feeding damage or "bugburn" caused by the rice black bug. To confirm hopperburn caused by planthoppers, check for the presence of sooty molds at the base of the plant.

Countermeasures for Rice brown plant hopper.

How to manage:
Outbreaks result from pesticides destroying natural enemies (BPH eggs hatch unchecked, and surviving BPH quickly build-up populations to damaging levels), or when longwinged planthoppers are being carried in by the wind.

To prevent outbreaks of planthopper:

Remove weeds from the field and surrounding areas.
Avoid indiscriminate use of insecticide, which destroys natural enemies.
Use a resistant variety. Contact your local agriculture office for an up-to-date list of available varities.
Critical numbers: At a density of 1 BPH/stem or less there is still time to act in case the numbers increase.
Look for BPH daily in the seedbed, or weekly in the field, on stems and the water surface. Check each side of the seed bed (or direct-seeded fields). For older rice plants, grasp the plant, bend it over slightly, and gently tap it near the base to see if planthoppers fall onto the water surface. For transplanted rice look at bases of 10 to 20 hills as you cross the field diagonally. There is no need to scout for BPH or WBPH beyond the milk stage.
Use light traps (e.g., an electric bulb or kerosene lamp near a light colored wall or over a pan of water) at night when rice is prone to planthopper attack. Do not place lights near seedbeds or fields. If the light trap is inundated with hundreds of BPH, it's a signal to check your seedbed or field immediately; then scout every day for the next few weeks. If farmers monitor on a daily basis anyway, then a light trap is unnecessary.
To control planthoppers:

Mechanical & physical measures

Flood the seedbed, for a day, so that only the tips of seedlings are exposed will control BPH.
Sweep small seedbeds with a net to remove some BPH (but not eggs), particularly from dry seed beds. At high BPH densities, sweeping will not remove sufficient numbers of BPH from the base of the plant.
Biological control

If natural enemies out-number BPH the risk of hopperburn is low. Even rice already damaged by hopperburn should not be treated with insecticides if natural enemies out-number BPH. Natural enemies of BPH include water striders, mirid bugs, spiders, and various egg parasitoids.
Chemical control

Only apply insecticides to the seedbed, for BPH or WBPH, if all of these conditions are met:

an average of more than one planthopper per stem,
on average, more planthoppers than natural enemies,
flooding the seedbed is not an option.

Source: http://www.knowledgebank.irri.org/training/fact-sheets/pest-management/insects/item/planthopper?fbclid=IwAR0PRmfxznU2Y3zZ7irQeVk4Pko9OdO8-WGibXjxeZyu8PbPbKyv_RYL6Bs

''';
      case 'green-leafhopper':
        return '''
What it does:
Green leafhoppers are the most common leafhoppers in rice fields and are primarily critical because they spread the viral disease tungro. Both nymphs and adults feed by extracting plant sap with their needle-shaped mouthparts.

Why and where it occurs:
Staggered planting encourages population growth of GLH.

Green leafhoppers are common in rainfed and irrigated wetland environments. They are not prevalent in upland rice. Both the nymphs and adults feed on the dorsal surface of the leaf blades rather than the ventral surface. They prefer to feed on the lateral leaves rather than the leaf sheaths and the middle leaves. They also prefer rice plants that have been fertilized with large amount of nitrogen.

How to identify:
Rice fields infested by GLH can have tungro, yellow dwarf, yellow-orange leaf, and transitory yellowing diseases.

Symptoms include:

stunted plants and reduced vigor
reduced number of productive tillers
withering or complete plant drying
Tungro infected crops may sometimes be confused with nitrogen deficiency or iron toxicity or acid soils. To confirm the cause of the problem, check for virus infected plants in the fields, and the presence of the insect:

white or pale yellow eggs inside leaf sheaths or midribs
yellow or pale green nymphs with or without black markings
pale green adults with or without black markings feeding on upper parts of the crop

Countermeasures for green leafhopper.

Why is it important:
Green leafhoppers are important pests. They are vectors of viral diseases such as tungro, yellow dwarf, yellow-orange leaf, transitory yellowing, and dwarf.

How to manage:
Use GLH-resistant and tungro-resistant varieties. Contact your local agriculture office for an up-to-date list of available varieties.
Reduce the number of rice crops to two per year and synchronized crop establishment across farms reduces leafhoppers and other insect vectors.
Transplant older seedlings (>3 weeks) to reduce viral disease susceptibility transmitted by leafhoppers.
Plant early within a given planting period, particularly in the dry season to reduce the risk of insect-vector disease.
Avoid planting during the peak of GLH activity (shown by historical records) to avoid infestation. Light traps can be used to show GLH numbers.
Apply nitrogen as needed (e.g., using the Leaf Color Chart) to avoid contributing to population outbreaks by applying too much nitrogen, or hindering plant recovery from planthopper damage by applying insufficient nitrogen.
Control weeds in the field and on the bunds to remove the preferred grassy hosts of GLH and promotes crop vigor.
Perform crop rotation with a non-rice crop during the dry season to decrease alternate hosts for diseases.
Intercrop upland rice with soybean to reduce the incidence of leafhoppers on rice.
In areas without tungro source, insecticides are not needed, avoid spraying of insecticide (it is often unable to prevent or reduce tungro infections).

Encourage biological control agents: small wasps (parasitize the eggs), mirid bug; strepsipterans, small wasps, pipunculid flies, and nematodes (parasitize both the nymphs and adults), aquatic veliid bugs, nabid bugs, empid flies, damselflies, dragonflies, and spiders, fungal pathogen (attacks both nymph and adult).

Source: http://www.knowledgebank.irri.org/training/fact-sheets/pest-management/insects/item/green-leafhopper?fbclid=IwAR2w-ZRuFE4seBrTWr-ecdl1uQKwemVRg_fUXomgb-bIdGzwJsya12MkaGs

''';
      case 'leaf-folder':
        return '''
What it does
Leaffolder caterpillars fold a rice leaf around themselves and attach the leaf margins together with silk strands.

They feed inside the folded leaf creating longitudinal white and transparent streaks on the blade.

Why and where it occurs
Heavy use of fertilizer encourages rapid multiplication of the insect. High humidity and shady areas of the field, as well as the presence of grassy weeds from rice fields and surrounding borders favor the development of the pest.

Expanded rice areas with irrigation systems, multiple rice cropping and insecticide induced resurgences are important factors in the insect’s abundance.

Rice leaffolders occur in all rice environments and are more abundant during the rainy seasons. They are commonly found in shady areas and areas where rice is heavily fertilized. In tropical rice areas, they are active year-round, whereas in temperate countries they are active from May to October. The adults are nocturnal and during the day, they stay under shade to escape predation. Moths fly short distances when disturbed.

How to identify
Check the plant for the following symptoms:

longitudinal and transparent whitish streaks on damaged leaves
tubular folded leaves
leaf tips sometimes fastened to the basal part of leaf
heavily infested fields appear scorched with many folded leaves 

Also check for presence of insects, particularly during tillering to flowering. Signs include:
disc-shaped ovoid eggs laid singly,
young larvae feeding on the base of the youngest unopened leaves,
folded leaves enclosing the feeding larvae, and
present fecal matter.

Why is it important
The damage caused by leaffolders may be important when it affects more than half of the flag leaf and the next two youngest leaves in each tiller.

At vegetative phase, crops can generally recover from damage; but when leaffolders infest at reproductive phase, the damage can be economically important. High feeding damage on the flag leaves can cause yield loss.

Most early season insecticide use have little or no economic returns. Instead, it can cause ecological disruptions in natural biological control processes, thus enhancing the development of secondary pests, such as planthoppers.

How to manage

To prevent leaffolder outbreaks:

Use resistant varieties.
Contact your local agriculture office for an up-to-date list of available varieties.
Follow rice with a different crop, or fallow period.
Avoid ratooning.
Flood and plow field after harvesting if possible.
Remove grassy weeds from fields and borders.
Reduce density of planting.
Use balanced fertilizer rates.
Spraying pesticides is not advisable during early crop stages. Many farmers in Asia lack the necessary safety equipment and expertise to use pesticides safely and therefore should not use them. See a crop protection specialist for guidance specific to your situation.

Source: http://www.knowledgebank.irri.org/training/fact-sheets/pest-management/insects/item/rice-leaffolder
''';
      case 'rice-bug':
        return '''
What it does?factsheet-black-bug
Black bugs remove the sap of the plant. They can cause browning of leaves, deadheart, and bugburn. Their damage also causes stunting in plants, reduced tiller number, and formation of whiteheads.

On severe cases, black bugs weaken the plant preventing them from producing seeds.

Why and where it occurs
The insect is common in rainfed and irrigated wetland environments. It prefers continuously cropped irrigated rice areas and poorly drained fields. Damages are observed more frequently in dry season rice crops and densely planted fields.

Black bug flight patterns are affected by the lunar cycle; on full moon nights, large numbers of adults swarm to light sources.

Staggered planting of the rice crop and excessive nitrogen also favor the buildup of the pest. During non-rice periods, the presence of alternate breeding site favors population increase.

How to identify
Check leaves for discoloration. Black bug damage can cause reddish brown or yellowing of plants. Leaves also have chlorotic lesions.
Check for decreased tillering. Bugburn symptoms show wilting of tillers with no visible honeydew deposits or sooty molds.
Plants are also stunted; and can develop stunted panicles, no panicles, incompletely exerted panicles, and unfilled spikelets or whiteheads at booting stage.
Check for deadhearts.
black-bug-1

Deadhearts can also be caused by stemborer. To confirm cause of damage, pull infected plants. In black bug damage, infected plants cannot be pulled at the bases.

Heavy infestation and "bugburn" is usually visible after heading or maturing.

Why is it important
Black bug feeds on the rice plant from seedling to maturity growth stages. Ten black bug adults per hill can cause losses of up to 35% in some rice.

How to manage
To prevent black bug infestation:

Use resistant varieties.
Contact your local agriculture office for up-to-date lists of varieties available.
Maintain a clean field by removing the weeds and drying the rice field after plowing.
Plant rice varieties of the same maturity date to break the insect’s cycle.
Use of mercury bulbs as light traps for egg-laying adults, light trapping of insects should start 5 days before and after the full moon.
Encourage biological control agents, such as small wasps (parasitize the eggs), ground beetles, spiders, crickets, and red ants (attack the eggs, nymphs, and adults), coccinellid beetles, ducks, toads (feed on eggs and nymphs), fungi species (attacks nymphs and adults).
To control black bug infestation:

During early infestation, raise the water level in the field for 2−3 days to force the insects to move upwards.
Flood the fields. This can cause higher egg mortality.
After harvest, plow fields to remove remaining insects.
''';
      case 'stem-borer':
        return '''
What it does:
Stem borers can destroy rice at any stage of the plant from seedling to maturity.

They feed upon tillers and causes deadhearts or drying of the central tiller, during vegetative stage; and causes whiteheads at reproductive stage.

Why and where it occurs:
The stem borer larvae bore at the base of the plants during the vegetative stage. On older plants, they bore through the upper nodes and feed toward the base.

The yellow stem borer is a pest of deepwater rice. It is found in aquatic environments where there is continuous flooding. Second instar larvae enclose themselves in body leaf wrappings to make tubes and detach themselves from the leaf and falls onto the water surface. They attach themselves to the tiller and bore into the stem.

How to identify
Check the field for the following damage symptoms:

Deadhearts or dead tillers that can be easily pulled from the base during the vegetative stages
Whiteheads during reproductive stage where the emerging panicles are whitish and unfilled or empty
Tiny holes on the stems and tillers
Frass or fecal matters inside the damaged stems
Deadhearts and whiteheads symptoms may sometimes be confused with damages caused by rats, neck blast, and black bug diseases.

To confirm stem borer damage, visually inspect rice crop for deadhearts in the vegetative stages and whiteheads in reproductive stages. Stems can be pulled and dissected for larvae and pupae for confirmation of stem borer damage.

Countermeasures for yellow stemborer.

Why is it important
Excessive boring through the sheath can destroy the crop. Its damage can reduce the number of reproductive tillers. At late infection, plants develop whiteheads.

Yellow stemborer damage can lead to about 20% yield loss in early planted rice crops, and 80% in late-planted crops.
White stemborer is an important pest in rainfed wetland rice. It can cause outbreaks and destroy rice fields.
Striped stemborer is one of the most important insect pests in Asia. Its damage can be as high as 100% when severe.
Gold-fringed stemborer can cause yield loss of about 30%.

How to manage
Use resistant varieties
At seedbed and transplanting, handpick and destroy egg masses
Raise level of irrigation water periodically to submerge the eggs deposited on the lower parts of the plant
Before transplanting, cut the leaf-top to reduce carry-over of eggs from the seedbed to the field
Ensure proper timing of planting and synchronous planting, harvest crops at ground level to remove the larvae in stubble, remove stubble and volunteer rice, plow and flood the field
Encourage biological control agents: braconid, eulophid, mymarid, scelionid, chalcid, pteromalid and trichogrammatid wasps, ants, lady beetles, staphylinid beetles, gryllid, green meadow grasshopper, and mirid, phorid and platystomatid flies, bethylid, braconid, elasmid, eulophid, eurytomid and ichneumonid wasps, carabid and lady bird beetles, chloropid fly, gerrid and pentatomid bugs, ants, and mites,  earwigs, bird, asilid fly, vespid wasp, dragonflies, damselflies, and spiders
Bacteria and fungi also infect the larvae: mermithid nematode, chalcid, elasmid and eulophid
Apply nitrogen fertilizer in split following the recommended rate and time of application.

Source: http://www.knowledgebank.irri.org/training/fact-sheets/pest-management/insects/item/planthopper?fbclid=IwAR0PRmfxznU2Y3zZ7irQeVk4Pko9OdO8-WGibXjxeZyu8PbPbKyv_RYL6Bs

''';
      case 'whorl-maggot':
        return '''
What it does
The feeding damage of whorl maggots causes yellow spots, white or transparent patches, and pinholes.

The larva uses its hardened mouth hooks to rasp the tissues of unopened leaves or the growing points of the developing leaves. The damage becomes visible when the leaves grow old. Mature larva prefers to feed on the developing leaves of the new developing tillers at the base of the rice plant.

Why and where it occurs
rice-whorl-maggot-1Standing water in paddies during the vegetative stage, presence of host plants year-round, and transplanting of young seedlings favor the development of rice whorl maggot.

The rice whorl maggot is semi-aquatic. It is common in irrigated fields and feeds on the central whorl leaf of the vegetative stage of the rice plant. It does not occur in upland rice. It also prefers ponds, streams and lakes or places with abundant calm water and lush vegetation.

The insect does not prefer direct-seeded fields and seedbeds. The adult is active during the day and rests on rice leaves near the water. It floats on the water or perches on floating vegetation. At midday, it is sedentary or it clings on upright vegetation. It prefers thick vegetation and is attracted to open standing water around seedbeds. Neonate maggots feed on the unopened central leaves where larval development is completed in 10−12 days. The full-grown maggots pupate outside the feeding stalk.

How to identify
rice-whorl-maggot-damage

Check the plant for the following symptoms:

white or transparent patches
pinholes
damaged leaves easily break from the wind
somewhat distorted leaves
clear or yellow spots on inner margins of emerging leaves
stunting
few tillers
Check for the presence of insects:

elongate, white eggs glued on leaves
transparent to light cream legless young larvae rasping the tissues of unopened leaves
yellow mature larva feeding on developing leaves of the new developing tillers at the base of the rice plant

Why is it important
The rice whorl maggot begins to infest the rice plant at transplanting. It locates rice fields by reflected sunlight from the water surface.

Using insecticides is not recommended for the rice whorl maggot control because the rice plant can compensate for the damage.

How to manage
There is no cultural control for rice whorl maggot.

Small wasps parasitized the eggs and the maggots. Dolicopodid flies prey on the eggs and ephydrid flies and spiders feed on the adults.

The rice plant can compensate for the damage caused by the rice whorl maggot. Usually, the symptoms disappear during the maximum tillering stage of the crop.
''';
      // Add more cases as needed
      default:
        return 'No specific countermeasures available for $detectedPestClassName.';
    }
  }
}
