Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A12E727F
	for <lists+kvmarm@lfdr.de>; Tue, 29 Dec 2020 18:04:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2FBE04B28D;
	Tue, 29 Dec 2020 12:04:43 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -0.598
X-Spam-Level: 
X-Spam-Status: No, score=-0.598 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	RDNS_NONE=0.793, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armlinux.org.uk
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0yj0sbrJzY8r; Tue, 29 Dec 2020 12:04:43 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 110894B290;
	Tue, 29 Dec 2020 12:04:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8A8934B255
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Dec 2020 12:04:40 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLIg01xBsFlz for <kvmarm@lists.cs.columbia.edu>;
 Tue, 29 Dec 2020 12:04:39 -0500 (EST)
Received: from pandora.armlinux.org.uk (unknown [78.32.30.218])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 006D64B249
 for <kvmarm@lists.cs.columbia.edu>; Tue, 29 Dec 2020 12:04:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FhCXE7slKDeIxopRDJZcSEDk1dcwjpLiihzO8A1DLYI=; b=AYhIRsKhcTRQMcw8YcP2xAlQP
 ZJ7L1gjPikShRcrMBIm+phM9DzBwgyb0v11vAj4qepLHcuoQCQ/NlJtACcoE85OrXpInyCAaBMdSK
 Td2Oykho2vQPWR407CJe6NN7DvuTOvf4sZVp/IqpijQq4Ql19Eth2DJJNXKEADW40L9qBSdzqth9B
 EFsTsXoylISXM1eFdZlh/4udhreDKyRgx2I56jZQ5P2Y9KY1s7hN0PXwTmxKSY1hBY9a8Zin52g22
 EXWzcXymEZ+3X3p4nwONwEJSJrHE8RtZQ5JTPQcg5BmKCwqOrdP16VOMLuXW4iPmd675vwWZ8D84Y
 UNTNCYeMQ==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44878)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1kuIPv-0005F2-Sw; Tue, 29 Dec 2020 17:04:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1kuIPs-0001ON-Dm; Tue, 29 Dec 2020 17:04:12 +0000
Date: Tue, 29 Dec 2020 17:04:12 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: David Brazdil <dbrazdil@google.com>
Subject: Re: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
Message-ID: <20201229170412.GN1551@shell.armlinux.org.uk>
References: <20201229160059.64135-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201229160059.64135-1-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, kernel-team@android.com,
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

On Tue, Dec 29, 2020 at 04:00:59PM +0000, David Brazdil wrote:
> The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET should
> not return, as dictated by the PSCI spec. However, there is firmware out
> there which breaks this assumption, leading to a hyp panic. Make KVM
> more robust to broken firmware by allowing these to return.

Are you sure you should just return?

We've had issues in the past with Linux reboot(2) that returns
to userspace, allowing on 32-bit ARM for example watchdogs to
unexpectedly continue being serviced.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
