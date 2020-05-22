Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 323761DE7C1
	for <lists+kvmarm@lfdr.de>; Fri, 22 May 2020 15:12:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 96F964B291;
	Fri, 22 May 2020 09:12:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHVVR3YeSqn2; Fri, 22 May 2020 09:12:20 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 6CA904B282;
	Fri, 22 May 2020 09:12:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5B18D4B281
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 May 2020 09:12:18 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BAWb7ZiX2l0T for <kvmarm@lists.cs.columbia.edu>;
 Fri, 22 May 2020 09:12:17 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 1257A4B265
 for <kvmarm@lists.cs.columbia.edu>; Fri, 22 May 2020 09:12:17 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86F36D6E;
 Fri, 22 May 2020 06:12:16 -0700 (PDT)
Received: from bogus (unknown [10.37.12.95])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C23A03F68F;
 Fri, 22 May 2020 06:12:12 -0700 (PDT)
Date: Fri, 22 May 2020 14:12:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jianyong Wu <jianyong.wu@arm.com>
Subject: Re: [RFC PATCH v12 03/11] psci: export smccc conduit get helper.
Message-ID: <20200522131206.GA15171@bogus>
References: <20200522083724.38182-1-jianyong.wu@arm.com>
 <20200522083724.38182-4-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200522083724.38182-4-jianyong.wu@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: kvm@vger.kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 justin.he@arm.com, Wei.Chen@arm.com, maz@kernel.org, steven.price@arm.com,
 richardcochran@gmail.com, yangbo.lu@nxp.com, john.stultz@linaro.org,
 tglx@linutronix.de, nd@arm.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, Sudeep Holla <sudeep.holla@arm.com>,
 pbonzini@redhat.com
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

On Fri, May 22, 2020 at 04:37:16PM +0800, Jianyong Wu wrote:
> Export arm_smccc_1_1_get_conduit then modules can use smccc helper which
> adopts it.
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  drivers/firmware/psci/psci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2937d44b5df4..fd3c88f21b6a 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -64,6 +64,7 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
>
>  	return psci_ops.conduit;
>  }
> +EXPORT_SYMBOL(arm_smccc_1_1_get_conduit);
>

I have moved this into drivers/firmware/smccc/smccc.c [1]
Please update this accordingly.

Also this series is floating on the list for a while now, it is time to
drop "RFC" unless anyone has strong objection to the idea here.

--
Regards,
Sudeep

[1] https://git.kernel.org/arm64/c/f2ae97062a48
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
