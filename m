Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE829755C
	for <lists+kvmarm@lfdr.de>; Fri, 23 Oct 2020 18:55:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 469794B6DC;
	Fri, 23 Oct 2020 12:55:46 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mq2JlY1gclhN; Fri, 23 Oct 2020 12:55:46 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id EB4C44B6CE;
	Fri, 23 Oct 2020 12:55:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5D8914B65F
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Oct 2020 12:55:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5CuE2ELWkfZi for <kvmarm@lists.cs.columbia.edu>;
 Fri, 23 Oct 2020 12:55:43 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1B8174B65E
 for <kvmarm@lists.cs.columbia.edu>; Fri, 23 Oct 2020 12:55:43 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4971FB;
 Fri, 23 Oct 2020 09:55:42 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B783F719;
 Fri, 23 Oct 2020 09:55:41 -0700 (PDT)
Subject: Re: [PATCH 5/6] drivers/acpi: Import ACPI APF table
To: Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
References: <20200818011319.91777-1-gshan@redhat.com>
 <20200818011319.91777-6-gshan@redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <1c18bb2d-ee35-499c-8d8a-2ed889e5d9bb@arm.com>
Date: Fri, 23 Oct 2020 17:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200818011319.91777-6-gshan@redhat.com>
Content-Language: en-GB
Cc: maz@kernel.org, will@kernel.org, shan.gavin@gmail.com, pbonzini@redhat.com
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

Hi Gavin,

On 18/08/2020 02:13, Gavin Shan wrote:
> This defines the struct for ACPI APF table. The information included
> in this table will be used by guest kernel to retrieve SDEI event
> number, PPI number and its triggering properties:
> 
>    * @sdei_event: number of SDEI event used for page-not-present
>    * @interrupt:  PPI used for page-ready
>    * @interrupt_flags: PPI's mode and polarity
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  include/acpi/actbl2.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)


Whoa! This is not how changes to ACPI work!

We have to work out what is needed, then the standard has to be updated, then the upstream
acpica project, then these files get synced back across from the 'upstream' acpica project...

If you need an ACPI table, we need something for DT too. I don't think a well designed
paravirt interface shouldn't need this. Wasn't that the whole point of the KVM "vendor
specific" services?!

The cover-letter message talks of shared memory, which this doesn't describe.

Ideally this stuff would be discovered via SMCCC, or a (readonly?) page of that shared
memory. That way its the same regardless of ACPI or DT.


Thanks,

James
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
