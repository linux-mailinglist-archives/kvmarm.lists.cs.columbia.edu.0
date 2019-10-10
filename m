Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA87D2BE3
	for <lists+kvmarm@lfdr.de>; Thu, 10 Oct 2019 15:57:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BA2644A849;
	Thu, 10 Oct 2019 09:57:36 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jyQqulU1nyOQ; Thu, 10 Oct 2019 09:57:36 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63B0F4A832;
	Thu, 10 Oct 2019 09:57:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D769B4A80E
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Oct 2019 09:57:34 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QjN2M5MXM3OX for <kvmarm@lists.cs.columbia.edu>;
 Thu, 10 Oct 2019 09:57:32 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1988C4A6B2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 10 Oct 2019 09:57:32 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 434418372F2;
 Thu, 10 Oct 2019 13:57:31 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80CE16012A;
 Thu, 10 Oct 2019 13:57:25 +0000 (UTC)
Date: Thu, 10 Oct 2019 15:57:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [RFC PATCH 12/12] virt/acpi: add SDEI table if SDEI is enabled
Message-ID: <20191010155723.24acb321@redhat.com>
In-Reply-To: <3e889d37-b877-f7b5-7ee3-70cef6d8e9c1@huawei.com>
References: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
 <1569338511-3572-13-git-send-email-guoheyi@huawei.com>
 <20191010111537.5e2dd584@redhat.com>
 <3e889d37-b877-f7b5-7ee3-70cef6d8e9c1@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 10 Oct 2019 13:57:31 +0000 (UTC)
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>, qemu-arm@nongnu.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, 10 Oct 2019 21:08:10 +0800
Guoheyi <guoheyi@huawei.com> wrote:

> Thanks for your comments.
> 
> On 2019/10/10 17:15, Igor Mammedov wrote:
> > On Tue, 24 Sep 2019 23:21:51 +0800
> > Heyi Guo <guoheyi@huawei.com> wrote:
> >  
> >> Add SDEI table if SDEI is enabled, so that guest OS can get aware and
> >> utilize the interfaces.
> >>
> >> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Cc: Dave Martin <Dave.Martin@arm.com>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: James Morse <james.morse@arm.com>
> >> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >>   hw/arm/virt-acpi-build.c    | 16 ++++++++++++++++
> >>   include/hw/acpi/acpi-defs.h |  5 +++++
> >>   2 files changed, 21 insertions(+)
> >>
> >> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> >> index 6cdf156..1088214 100644
> >> --- a/hw/arm/virt-acpi-build.c
> >> +++ b/hw/arm/virt-acpi-build.c
> >> @@ -32,6 +32,7 @@
> >>   #include "trace.h"
> >>   #include "hw/core/cpu.h"
> >>   #include "target/arm/cpu.h"
> >> +#include "target/arm/sdei.h"
> >>   #include "hw/acpi/acpi-defs.h"
> >>   #include "hw/acpi/acpi.h"
> >>   #include "hw/nvram/fw_cfg.h"
> >> @@ -475,6 +476,16 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>   }
> >>     
> > here should be a comment describing purpose with a reference to spec  
> OK.
> 
> >  
> >>   static void
> >> +build_sdei(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >> +{
> >> +    int sdei_start = table_data->len;
> >> +
> >> +    (void)acpi_data_push(table_data, sizeof(AcpiSdei));
> >> +    build_header(linker, table_data, (void *)(table_data->data + sdei_start),
> >> +                 "SDEI", table_data->len - sdei_start, 1, NULL, NULL);
> >> +}  
> > that's dummy table and doesn't match what spec describes,
> > It doesn't look correct SDEI table.  
> 
> Refer to below document, Appendix C, I see the definition of SDEI is 
> really a dummy table, also it is said in the document: The table 
> consists only of a basic header with revision 1.
> 
> http://infocenter.arm.com/help/topic/com.arm.doc.den0054a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf
> 
> Do I miss anything?
No you are right and I was mistaken.
It's pretty waste-full way to communicate to OS a Boolean flag
that a new GHEST event is supported. But since they managed to make
it a spec, it should be coded as such.


> 
> >  
> >> +
> >> +static void
> >>   build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>   {
> >>       AcpiSerialPortConsoleRedirection *spcr;
> >> @@ -796,6 +807,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >>       acpi_add_table(table_offsets, tables_blob);
> >>       build_spcr(tables_blob, tables->linker, vms);
> >>   
> >> +    if (sdei_enabled) {
> >> +        acpi_add_table(table_offsets, tables_blob);
> >> +        build_sdei(tables_blob, tables->linker, vms);
> >> +    }
> >> +
> >>       if (ms->numa_state->num_nodes > 0) {
> >>           acpi_add_table(table_offsets, tables_blob);
> >>           build_srat(tables_blob, tables->linker, vms);
> >> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> >> index 57a3f58..0a2265d 100644
> >> --- a/include/hw/acpi/acpi-defs.h
> >> +++ b/include/hw/acpi/acpi-defs.h
> >> @@ -634,4 +634,9 @@ struct AcpiIortRC {
> >>   } QEMU_PACKED;
> >>   typedef struct AcpiIortRC AcpiIortRC;
> >>   
> >> +struct AcpiSdei {
> >> +    ACPI_TABLE_HEADER_DEF     /* ACPI common table header */
> >> +} QEMU_PACKED;
> >> +typedef struct AcpiSdei AcpiSdei;  
> > we don't use packed structures for ACPI anymore, see build_rsdp() for
> > example of how tables are composed and comment style required for each field.  
> Sure; will fix it in v2.
> 
> Thanks,
> 
> Heyi
> 
> >  
> >>   #endif  
> >
> > .
> >  
> 
> 

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
