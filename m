Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3A1F5B6C
	for <lists+kvmarm@lfdr.de>; Wed, 10 Jun 2020 20:43:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 64DED4B215;
	Wed, 10 Jun 2020 14:43:16 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.091
X-Spam-Level: 
X-Spam-Status: No, score=-4.091 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, body has been altered) header.i=@kernel.org
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id StJZm79lQ+Oh; Wed, 10 Jun 2020 14:43:16 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 619C44B201;
	Wed, 10 Jun 2020 14:43:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 8082F4B19D
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 14:43:14 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bYev+Trabb62 for <kvmarm@lists.cs.columbia.edu>;
 Wed, 10 Jun 2020 14:43:13 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 8B3F24B134
 for <kvmarm@lists.cs.columbia.edu>; Wed, 10 Jun 2020 14:43:13 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 610962070B;
 Wed, 10 Jun 2020 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591814592;
 bh=vk+TyI0YXDcw/F4oBBcx2/OX0Q8DCn+GCXhtsjoEvUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RdP3NhHuaEqkiOhDW44QUO6Iw2GjL+5wD56VnCs+XjZUNDuVZEZ4gogpsz/dur0Mg
 XpQD+R+KfiehPnLIpulDDFblTJoF8qD3qWzt2gtI2dmwttpIWvOpmryGKbLtsLQot0
 B/R5TTjaAvruddHmxV4T1l46G2akDfah86nQBoUQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why.lan) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jj5gs-001rXS-U4; Wed, 10 Jun 2020 19:43:11 +0100
From: Marc Zyngier <maz@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix
 sleep in atomic
Date: Wed, 10 Jun 2020 19:43:07 +0100
Message-Id: <159181454880.1512339.2705658130320062146.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605052345.1494-1-yuzenghui@huawei.com>
References: <20200605052345.1494-1-yuzenghui@huawei.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de,
 jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: tglx@linutronix.de, jason@lakedaemon.net
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

On Fri, 5 Jun 2020 13:23:45 +0800, Zenghui Yu wrote:
> readx_poll_timeout() can sleep if @sleep_us is specified by the caller,
> and is therefore unsafe to be used inside the atomic context, which is
> this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
> irq_set_vcpu_affinity() callback.
> 
> Let's convert to its atomic version instead which helps to get the v4.1
> board back to life!
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic
      commit: a87d4e00eacbc95b44466e3470529f4de49b450a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
