Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 85385157FBF
	for <lists+kvmarm@lfdr.de>; Mon, 10 Feb 2020 17:26:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 377794AC7E;
	Mon, 10 Feb 2020 11:26:47 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@armlinux.org.uk
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wT0GvTwK21RK; Mon, 10 Feb 2020 11:26:47 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 138D74A959;
	Mon, 10 Feb 2020 11:26:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id EDF834A59B
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 11:26:44 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T8YPlJdfycXR for <kvmarm@lists.cs.columbia.edu>;
 Mon, 10 Feb 2020 11:26:43 -0500 (EST)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 67BA14A50F
 for <kvmarm@lists.cs.columbia.edu>; Mon, 10 Feb 2020 11:26:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=65bdrIaYUEY07Eg6lahVGNf+sXMz7DgHQPG+97GSzoU=; b=O249n01KJyJmh5v7eoKu72Wxm
 aT6PtOrlOoyebt8IeMBdWJ+Mc0G34pwCNSbq0pYUPEVnSHE8dOnkTdb88whOVZjCsaHxz+de39iuw
 yWGdC/Muzm1L1tlo8Yjkn1SETYGGIMiFmXrUylkja4lUEkM0nU9MJ8ufgf5CDc7P0iz1Cwj0bx9rJ
 /sVJEE2hjddOOmp19LpzoXQL2y7uBEKycflnocOXeWpZIs83p15iLxzw6REUj4m/ovum6O/B7IyuY
 8gdPpNCERbJCVPjnCguAIPq7nX4OSUNFDb7Dbgxau52hL0T9rKWjEzNmX5smg1KyJyTM8hvgHvd9N
 t9gGOlcEw==;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:38534)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1j1BtO-0007mo-Kh; Mon, 10 Feb 2020 16:26:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1j1BtN-00081o-CD; Mon, 10 Feb 2020 16:26:37 +0000
Date: Mon, 10 Feb 2020 16:26:37 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH 0/5] Removing support for 32bit KVM/arm host
Message-ID: <20200210162637.GG25745@shell.armlinux.org.uk>
References: <20200210141324.21090-1-maz@kernel.org>
 <20200210162523.GF25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200210162523.GF25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Anders Berg <anders.berg@lsi.com>, Arnd Bergmann <arnd@arndb.de>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu
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

On Mon, Feb 10, 2020 at 04:25:23PM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 10, 2020 at 02:13:19PM +0000, Marc Zyngier wrote:
> > KVM/arm was merged just over 7 years ago, and has lived a very quiet
> > life so far. It mostly works if you're prepared to deal with its
> > limitations, it has been a good prototype for the arm64 version,
> > but it suffers a few problems:
> > 
> > - It is incomplete (no debug support, no PMU)
> > - It hasn't followed any of the architectural evolutions
> > - It has zero users (I don't count myself here)
> > - It is more and more getting in the way of new arm64 developments
> > 
> > So here it is: unless someone screams and shows that they rely on
> > KVM/arm to be maintained upsteam, I'll remove 32bit host support
> > form the tree. One of the reasons that makes me confident nobody is
> > using it is that I never receive *any* bug report. Yes, it is perfect.
> > But if you depend on KVM/arm being available in mainline, please shout.
> 
> It is only very recently that 64-bit ARM has really started to filter
> down to people like me, and people like me have setup systems which
> use 32-bit VMs under 64-bit hosts (about a year ago now.)  In fact,
> everything that you presently see for the *.armlinux.org.uk domain now
> runs inside several 32-bit ARM VMs under a 64-bit ARM host.
> 
> It isn't perfect; I've found issues with qemu and libvirt.  One example
> is the rather sub-standard RTC implementation, which means if you
> use libvirt's managesave across a host reboot, the guests idea of
> time-of-day freezes while it's asleep, and resumes when the guest is
> reloaded - resulting in the guests time-of-day being rather wrong,
> sometimes to the point that NTP gives up.  That becomes very painful
> if you use kerberos authentication, where time-of-day is important.
> 
> So, just because you haven't received any bug reports doesn't mean
> there aren't any users; there certainly are, there are problems,
> but the problems are in places other than the kernel.

... argh, I see, you're not removing 32-bit guest on 64-bit.  Ignore
the above then.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
