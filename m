Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 64841389FF6
	for <lists+kvmarm@lfdr.de>; Thu, 20 May 2021 10:37:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9E0ED4B750;
	Thu, 20 May 2021 04:37:30 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.208
X-Spam-Level: 
X-Spam-Status: No, score=0.208 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_LOW=-0.7,
	SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@kroah.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@messagingengine.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0z6F5vpaQ5fi; Thu, 20 May 2021 04:37:30 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 63A204B731;
	Thu, 20 May 2021 04:37:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 08E014B5D2
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 04:37:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWj588glhidM for <kvmarm@lists.cs.columbia.edu>;
 Thu, 20 May 2021 04:37:28 -0400 (EDT)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 04CC94B5D0
 for <kvmarm@lists.cs.columbia.edu>; Thu, 20 May 2021 04:37:28 -0400 (EDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 2D397580725;
 Thu, 20 May 2021 04:37:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 20 May 2021 04:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=uN/paZHT/wy9V60QgAgEZGhZMfE
 PAIFK3VT5m0X1P1w=; b=DyqElVP72T2h8KWo4m3edK/aFE1RVet81qHItJSF6ZY
 W7atc0Ie/fysmc55BnsCOHQ+HAuNn7KFiXpTgGFw7mJGSm+3yO78hsmxZAGIj9tQ
 eoMRa3RnD5YYiFCcSdKHooFbto9MI27/KqFGDoOqQ413QGXIM3suDi0ry66hqIA4
 6w/PlTQMjOPeTV1v7ZLP2TKRLYNJX35UHfneIyClQf4/Po/6qQU4PRQtOlvkI6DN
 cRNKwisZ0B+h8haOu4rLWw4eYsz0sFLBGTIbjOgp0h5Y0hf1skqRw/MNQad5l9qA
 MTdLjLAzf2Ml0rzWaYKHINcnRk4fcOf378GeSIuI+QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uN/paZ
 HT/wy9V60QgAgEZGhZMfEPAIFK3VT5m0X1P1w=; b=vmeNFnj30tGwQ4olc3Hf7G
 aH0n45x7g4dT9U5lCFSrgfr1fnsJmzyXOBhTHEwzxbsMVx0WHyAW1QxTXtVjyqfs
 qM9HQ+CmfgCi/CpeBl64QY+4SXVqrHqIsXA6ra0D4V9JQ3rtWf70BQVo6yi8WpyB
 bLmmeFqrVgi1x32UVSp5YBz+fR+initDRjHJMLSJu0+oFGM/cCgvcNgvEDeRgXZe
 AxpcK7qjDHSGhaL1XGludZb19p60Hx5jOJbDNmC7G8wwaATtwsRiUrlPkeNornps
 uT1r41JCA/4gdtxzt5Up6X4mMe9W4Mbpc0ti4S4InCtLW3VgQXLfboM+46CXKPDA
 ==
X-ME-Sender: <xms:xB-mYBcX-bP9zl8pwOjgEa0faf1i9zHCeIur-PWgffpIoDvtqbpyFA>
 <xme:xB-mYPOa9-4WHSTXwAnoMk7ooaCASkL1wO_ek7I-HZnXOZaWp27XKjr9KTYuZnBKh
 sGsqLSxOPhk0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejuddgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefirhgvghcu
 mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevhefgje
 eitdfffefhvdegleeigeejgeeiffekieffjeeflefhieegtefhudejueenucfkphepkeef
 rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:xR-mYKijB76mo5krd25P4UK9_y5r6g3eryM_Yt5-un5I3JS0Fyw-vg>
 <xmx:xR-mYK8KDZq6L6FDyYMditMPW49tYEeGn6bP8dmCCrpFZRFEf8LowQ>
 <xmx:xR-mYNuKviavCH9znzZLAzol0taNSLruz7LKtS9o_54-AufGOW8klA>
 <xmx:xh-mYJEWESWYFyLWwYDncUDJn5PcU4uW-GHG06OMz7LL-7grdmA-GQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 by mail.messagingengine.com (Postfix) with ESMTPA;
 Thu, 20 May 2021 04:37:24 -0400 (EDT)
Date: Thu, 20 May 2021 10:37:22 +0200
From: Greg KH <greg@kroah.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH for-stable-5.4] KVM: arm64: Initialize VCPU mdcr_el2
 before loading it
Message-ID: <YKYfwqrZsAVniGsD@kroah.com>
References: <20210517142713.400651-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517142713.400651-1-alexandru.elisei@arm.com>
Cc: maz@kernel.org, stable@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Mon, May 17, 2021 at 03:27:13PM +0100, Alexandru Elisei wrote:
> [ Upstream commit 263d6287da1433aba11c5b4046388f2cdf49675c ]
> 
> When a VCPU is created, the kvm_vcpu struct is initialized to zero in
> kvm_vm_ioctl_create_vcpu(). On VHE systems, the first time
> vcpu.arch.mdcr_el2 is loaded on hardware is in vcpu_load(), before it is
> set to a sensible value in kvm_arm_setup_debug() later in the run loop. The
> result is that KVM executes for a short time with MDCR_EL2 set to zero.
> 
> This has several unintended consequences:
> 
> * Setting MDCR_EL2.HPMN to 0 is constrained unpredictable according to ARM
>   DDI 0487G.a, page D13-3820. The behavior specified by the architecture
>   in this case is for the PE to behave as if MDCR_EL2.HPMN is set to a
>   value less than or equal to PMCR_EL0.N, which means that an unknown
>   number of counters are now disabled by MDCR_EL2.HPME, which is zero.
> 
> * The host configuration for the other debug features controlled by
>   MDCR_EL2 is temporarily lost. This has been harmless so far, as Linux
>   doesn't use the other fields, but that might change in the future.
> 
> Let's avoid both issues by initializing the VCPU's mdcr_el2 field in
> kvm_vcpu_vcpu_first_run_init(), thus making sure that the MDCR_EL2 register
> has a consistent value after each vcpu_load().
> 
> [ v5.4 backport: added stub for KVM/arm that fixes compilation errors ]

Thanks for both backports, now queued up.

greg k-h
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
