import { ClickableCard } from "@bloom-housing/shared-helpers"
import { RegionEnum } from "@bloom-housing/shared-helpers/src/types/backend-swagger"
import { Grid, Link } from "@bloom-housing/ui-seeds"
import styles from "./HomeRegions.module.scss"

export const HomeRegions = () => {
  const availableRegions = Object.values(RegionEnum).map((region) => ({
    title: region.replace("_", " "),
    enum: region,
  }))

  const regionImageUrls: Map<RegionEnum, string> = new Map([
    [
      RegionEnum.Greater_Downtown,
      "https://res.cloudinary.com/exygy/image/upload/dev/greater_downtown_cpf0r9.jpg",
    ],
    [RegionEnum.Eastside, "https://res.cloudinary.com/exygy/image/upload/dev/eastside_cuaa5k.jpg"],
    [
      RegionEnum.Southwest,
      "https://res.cloudinary.com/exygy/image/upload/dev/southwest_mbtr4g.jpg",
    ],
    [RegionEnum.Westside, "https://res.cloudinary.com/exygy/image/upload/dev/westside_qbysre.jpg"],
  ])

  return (
    <Grid>
      <Grid.Row columns={4}>
        {availableRegions.map((region) => (
          <Grid.Cell key={region.enum}>
            <ClickableCard className={styles["region-card"]}>
              <div className={styles["region-card-image"]}>
                <img src={regionImageUrls.get(region.enum)} alt={region.title} />
              </div>
              <Link href={"/listings"} className={styles["region-card-name"]}>
                {region.title}
              </Link>
            </ClickableCard>
          </Grid.Cell>
        ))}
      </Grid.Row>
    </Grid>
  )
}
