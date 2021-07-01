Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id B665E3B9010
	for <lists+kvmarm@lfdr.de>; Thu,  1 Jul 2021 11:55:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 2F4154B080;
	Thu,  1 Jul 2021 05:55:12 -0400 (EDT)
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
	with ESMTP id YMyr+NeNlf9Y; Thu,  1 Jul 2021 05:55:12 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 01BFD4AEF8;
	Thu,  1 Jul 2021 05:55:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 3E1B54A4A0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Jul 2021 05:55:09 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uO98igkC5EVp for <kvmarm@lists.cs.columbia.edu>;
 Thu,  1 Jul 2021 05:55:04 -0400 (EDT)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 1189C406D3
 for <kvmarm@lists.cs.columbia.edu>; Thu,  1 Jul 2021 05:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4ISMbJgxh4MN3I/dz1+lt1f6neKYoIuu0hFv4GIRZlY=; b=qYEKPVrHK+H/GAfvYbUJQQGaj
 pR59K5u22mfe210Cug69+BOdYcbVAsOr7zJiMfigpQ8/p9DCXiwzIQvzA5zPF/ngZ2uNNNiHMI9Tj
 wh950U+REOku26aYcn76EPBFWERoBIcpgjYbznoGTch+4c3WQrHbQatqknwf3XcsLSvVwGrpQo/rL
 4P2MbAPmKh0N1Y8rGRsQVp40HbFf6iJ5TtaiMa/xOTSt0GIKsR5g+3SmHbQdbGqxhoQLQd+uVl3DK
 n+v0zftYuwG3xWa03AsXHsmWJ48c9es5kBYW0wTEGWMXEndO5h2+nGTSDx8TIW/ypXi7EVnCUz9My
 Iyrw1J2yw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45572)
 by pandora.armlinux.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <linux@armlinux.org.uk>)
 id 1lytPO-00011Z-Bt; Thu, 01 Jul 2021 10:54:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1lytPK-0003zt-Oz; Thu, 01 Jul 2021 10:54:54 +0100
Date: Thu, 1 Jul 2021 10:54:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 4/5] KVM: arm64: Pass hypercalls to userspace
Message-ID: <20210701095454.GI22278@shell.armlinux.org.uk>
References: <20210608154805.216869-1-jean-philippe@linaro.org>
 <20210608154805.216869-5-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608154805.216869-5-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: salil.mehta@huawei.com, lorenzo.pieralisi@arm.com, kvm@vger.kernel.org,
 corbet@lwn.net, maz@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
 jonathan.cameron@huawei.com, catalin.marinas@arm.com, pbonzini@redhat.com,
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

On Tue, Jun 08, 2021 at 05:48:05PM +0200, Jean-Philippe Brucker wrote:
> * Untested for AArch32 guests.

That really needs testing; you may notice Will Deacon has been
posting patches for aarch32 guests over the last few months, and
there are other users out there who run aarch32 guests on their
aarch64 hardware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
