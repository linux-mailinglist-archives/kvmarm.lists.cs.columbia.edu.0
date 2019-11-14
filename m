Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id A688BFC8AF
	for <lists+kvmarm@lfdr.de>; Thu, 14 Nov 2019 15:19:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 42ABE4AF83;
	Thu, 14 Nov 2019 09:19:18 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6F1H-uYy5Ei; Thu, 14 Nov 2019 09:19:18 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2A8F24AECE;
	Thu, 14 Nov 2019 09:19:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 2C04B4AECE
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 09:19:15 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3w2yVeSfkcWK for <kvmarm@lists.cs.columbia.edu>;
 Thu, 14 Nov 2019 09:19:14 -0500 (EST)
Received: from Galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 001E64AEBD
 for <kvmarm@lists.cs.columbia.edu>; Thu, 14 Nov 2019 09:19:13 -0500 (EST)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1iVFxe-00046J-A5; Thu, 14 Nov 2019 15:19:02 +0100
Date: Thu, 14 Nov 2019 15:19:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jianyong Wu <jianyong.wu@arm.com>
Subject: Re: [RFC PATCH v7 4/7] time: Add mechanism to recognize clocksource
 in time_get_snapshot
In-Reply-To: <20191114121358.6684-5-jianyong.wu@arm.com>
Message-ID: <alpine.DEB.2.21.1911141507010.2507@nanos.tec.linutronix.de>
References: <20191114121358.6684-1-jianyong.wu@arm.com>
 <20191114121358.6684-5-jianyong.wu@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: justin.he@arm.com, kvm@vger.kernel.org, maz@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org,
 sean.j.christopherson@intel.com, john.stultz@linaro.org,
 netdev@vger.kernel.org, pbonzini@redhat.com, nd@arm.com, will@kernel.org,
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

On Thu, 14 Nov 2019, Jianyong Wu wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> In some scenario like return device time to ptp_kvm guest,
> we need identify the current clocksource outside core time code.
> A mechanism added to recognize the current clocksource
> by export clocksource id in time_get_snapshot.

Can you please replace that with the following:

 System time snapshots are not conveying information about the current
 clocksource which was used, but callers like the PTP KVM guest
 implementation have the requirement to evaluate the clocksource type to
 select the appropriate mechanism.

 Introduce a clocksource id field in struct clocksource which is by default
 set to CSID_GENERIC (0). Clocksource implementations can set that field to
 a value which allows to identify the clocksource.

 Store the clocksource id of the current clocksource in the
 system_time_snapshot so callers can evaluate which clocksource was used to
 take the snapshot and act accordingly.

> diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
> new file mode 100644
> index 000000000000..93bec8426c44
> --- /dev/null
> +++ b/include/linux/clocksource_ids.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CLOCKSOURCE_IDS_H
> +#define _LINUX_CLOCKSOURCE_IDS_H
> +
> +/* Enum to give clocksources a unique identifier */
> +enum clocksource_ids {
> +	CSID_GENERIC		= 0,
> +	CSID_ARM_ARCH_COUNTER,

This should only add the infrastructure with just CSID_GENERIC in place.

The ARM_ARCH variant needs to come in a seperate patch which adds the enum
and uses it in the corresponding driver. Seperate means a patch doing only
that and nothing else, i.e. not hidden in some other patch which actually
makes use of it.

Thanks,

	tglx
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
