Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id CDF0E18B323
	for <lists+kvmarm@lfdr.de>; Thu, 19 Mar 2020 13:18:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 628034B098;
	Thu, 19 Mar 2020 08:18:44 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id viBv2+Z-5e7P; Thu, 19 Mar 2020 08:18:44 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 3D7CE4B08F;
	Thu, 19 Mar 2020 08:18:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 91D9C4A4AA
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Mar 2020 08:18:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CC3c++k5UHwi for <kvmarm@lists.cs.columbia.edu>;
 Thu, 19 Mar 2020 08:18:41 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 98F854A4A0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 19 Mar 2020 08:18:41 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6518E20663;
 Thu, 19 Mar 2020 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584620320;
 bh=9n5iSscoqYAjXl49/svHpLf5qsJKzfPfCazHWgnTthY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hMSyvzWudmn5PzqltwH9zVaoJflLaueZMoY7JuIBTmbwkmjCNT2hHrPKP5wQH72Yh
 QFw0yTyO2UEaw6WkBq6MKpEtt6gXN8nHKmL84bm4cma4fb8H2wB9x2hE3YrL1/HpSO
 TyT89wwVpUtFpxgCHtakHPiwm6ZKyuZAtda9p8uI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jEu8E-00Dvom-M6; Thu, 19 Mar 2020 12:18:38 +0000
MIME-Version: 1.0
Date: Thu, 19 Mar 2020 12:18:38 +0000
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v5 21/23] KVM: arm64: GICv4.1: Reload VLPI configuration
 on distributor enable/disable
In-Reply-To: <7f112d75-166b-24eb-538d-e100242d8e9a@huawei.com>
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-22-maz@kernel.org>
 <7f112d75-166b-24eb-538d-e100242d8e9a@huawei.com>
Message-ID: <ed4b6d1f4a156e22c5c619e197fa4752@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, jason@lakedaemon.net,
 rrichter@marvell.com, tglx@linutronix.de, eric.auger@redhat.com,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Robert Richter <rrichter@marvell.com>,
 Thomas Gleixner <tglx@linutronix.de>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On 2020-03-18 03:17, Zenghui Yu wrote:
> On 2020/3/5 4:33, Marc Zyngier wrote:
>> Each time a Group-enable bit gets flipped, the state of these bits
>> needs to be forwarded to the hardware. This is a pretty heavy
>> handed operation, requiring all vcpus to reload their GICv4
>> configuration. It is thus implemented as a new request type.
> 
> [note to myself]
> ... and the status are forwarded to HW by programming VGrp{0,1}En
> fields of GICR_VPENDBASER when vPEs are made resident next time.

I've added something based on this comment to the commit message.

Thanks!

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
