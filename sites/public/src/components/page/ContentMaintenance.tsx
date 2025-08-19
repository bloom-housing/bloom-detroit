import React from "react"
import MaxWidthLayout from "../../layouts/max-width"
import { Heading } from "@bloom-housing/ui-seeds"
import Markdown from "markdown-to-jsx"
import heroStyles from "../../patterns/Hero.module.scss"
import styles from "./ContentMaintenance.module.scss"

const ContentMaintenance = () => {
  const maintenanceMessages = [
    {
      title: "Maintenance",
      message:
        "Detroit Home Connect is currently undergoing maintenance and is unavailable at this moment. We apologize for the inconvenience, and if you have any time-sensitive questions related to the site, please reach out to [detroithomeconnect@detroitmi.gov](mailto:detroithomeconnect@detroitmi.gov)",
    },
    {
      title: "Mantenimiento",
      message:
        "Detroit Home Connect se encuentra actualmente en mantenimiento y no está disponible en este momento. Disculpe las molestias. Si tiene alguna pregunta urgente sobre el sitio, comuníquese con [detroithomeconnect@detroitmi.gov](mailto:detroithomeconnect@detroitmi.gov)",
    },
    {
      title: "صيانة",
      message:
        "خدمة ديترويت هوم كونيكت تخضع حاليًا للصيانة وهي غير متاحة حاليًا. نعتذر عن أي إزعاج، وإذا كانت لديكم أي أسئلة تتعلق بالموقع، يُرجى التواصل معنا عبر البريد الإلكتروني [detroithomeconnect@detroitmi.gov](mailto:detroithomeconnect@detroitmi.gov)",
    },
    {
      title: "রক্ষণাবেক্ষণ",
      message:
        "ডেট্রয়েট হোম কানেক্ট বর্তমানে রক্ষণাবেক্ষণের অধীনে রয়েছে এবং এই মুহূর্তে এটি অনুপলব্ধ। অসুবিধার জন্য আমরা ক্ষমাপ্রার্থী, এবং যদি আপনার সাইট সম্পর্কিত কোনও সময়-সংবেদনশীল প্রশ্ন থাকে, তাহলে অনুগ্রহ করে [detroithomeconnect@detroitmi.gov](mailto:detroithomeconnect@detroitmi.gov) এ যোগাযোগ করুন।",
    },
  ]

  return (
    <>
      <h1 className="sr-only">Site down for maintenance</h1>
      <MaxWidthLayout className={heroStyles["hero-container"]}>
        <div className={styles["maintenance-container"]}>
          {maintenanceMessages.map((lang) => (
            <div className={styles["language-container"]}>
              <Heading priority={2} className={`${styles["maintenance-heading"]}`}>
                {lang.title}
              </Heading>
              <p className={styles["subtitle"]}>
                <Markdown>{lang.message}</Markdown>
              </p>
            </div>
          ))}
        </div>
      </MaxWidthLayout>
    </>
  )
}

export { ContentMaintenance as default, ContentMaintenance }
