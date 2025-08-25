import React from "react"
import { Heading } from "@bloom-housing/ui-seeds"
import Markdown from "markdown-to-jsx"
import styles from "./Maintenance.module.scss"

const Maintenance = (props: { isPartners?: boolean }) => {
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
      title: "রক্ষণাবেক্ষণ",
      message:
        "ডেট্রয়েট হোম কানেক্ট বর্তমানে রক্ষণাবেক্ষণের অধীনে রয়েছে এবং এই মুহূর্তে এটি অনুপলব্ধ। অসুবিধার জন্য আমরা ক্ষমাপ্রার্থী, এবং যদি আপনার সাইট সম্পর্কিত কোনও সময়-সংবেদনশীল প্রশ্ন থাকে, তাহলে অনুগ্রহ করে [detroithomeconnect@detroitmi.gov](mailto:detroithomeconnect@detroitmi.gov) এ যোগাযোগ করুন।",
    },
    {
      title: "صيانة",
      message:
        "خدمة ديترويت هوم كونيكت تخضع حاليًا للصيانة وهي غير متاحة حاليًا. نعتذر عن أي إزعاج، وإذا كانت لديكم أي أسئلة تتعلق بالموقع، يُرجى التواصل معنا عبر البريد الإلكتروني [detroithomeconnect@detroitmi.gov](mailto:detroithomeconnect@detroitmi.gov)",
      rtl: true,
    },
  ]

  return (
    <div className={props?.isPartners ? styles["maintenance-partners"] : ""}>
      <h1 className="sr-only">Site down for maintenance</h1>
      <div className={styles["maintenance-container"]}>
        {maintenanceMessages.map((lang) => (
          <div className={`${styles["language-container"]} ${lang?.rtl ? styles["rtl"] : ""}`}>
            <Heading priority={2} className={`${styles["maintenance-heading"]}`}>
              {lang.title}
            </Heading>
            <p>
              <Markdown>{lang.message}</Markdown>
            </p>
          </div>
        ))}
      </div>
    </div>
  )
}

export { Maintenance as default, Maintenance }
