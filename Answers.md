## Expliquez ce qu’est LazyVGrid et pourquoi on l’utilise.
LazyVGrid est un conteneur de mise en page dans SwiftUI qui arrange ses éléments enfants en grille verticale. Il est "paresseux" car il génère uniquement les vues qui sont actuellement affichées à l'écran.

## Expliquez les différents types de colonnes et pourquoi on utilise flexible ici.
.flexible : Ce type de colonnes s'ajuste à l'espace disponible.

.adaptive : Ces colonnes modifient leur taille en fonction de l'espace disponible. On doit définir une largeur minimale pour chaque colonne adaptive. Si cette largeur minimale est atteinte, une nouvelle colonne est créée.

.fixed : Ces colonnes ont une taille fixe, indépendamment de l'espace disponible. On définit la taille fixe.

## Votre grille ne doit pas être très jolie, expliquez pourquoi les images prennent toute la largeur de l’écran
Les images occupent toute la largeur de l'écran car les colonnes sont flexibles et s'adaptent à l'espace disponible.

## Expliquez les différences entre ces 3 méthodes.
Il s'agit d'une fonction. .resizable() : Ce modificateur est appliqué à une vue Image pour indiquer que l'image peut être redimensionnée.

.scaledToFill() : Ce modificateur est utilisé pour déterminer comment l'image doit remplir son cadre tout en conservant ses proportions d'origine. Il est souvent utilisé avec resizable.

.frame(width: geo.size.width, height: geo.size.height) : Ce modificateur permet de définir la taille de l'image.

.clipped() : Ce modificateur est utilisé pour couper une vue, généralement une image, afin de la limiter à une forme ou à un cadre spécifique.
