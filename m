Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBC23CA6F
	for <lists+kvmarm@lfdr.de>; Wed,  5 Aug 2020 14:13:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 15B234B86E;
	Wed,  5 Aug 2020 08:13:43 -0400 (EDT)
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
	with ESMTP id iBRCRQxl-Jjs; Wed,  5 Aug 2020 08:13:42 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id C55B64B85F;
	Wed,  5 Aug 2020 08:13:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D43834B82B
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 08:13:40 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uvu+hbzq85No for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Aug 2020 08:13:39 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 825C64B803
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Aug 2020 08:13:39 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4823D22CBB;
 Wed,  5 Aug 2020 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596629618;
 bh=nPo8SyJqUjJ9z0rJpRBpkkeu083JsBlxNsr28VDgX9c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DN/pSFKGnrcuF/DioT3fQLhKd9KxDsJUYUl0Lo82SO0RrZoUoAMS0p+RF2oNdR7j9
 0icBWKv46n1IcKVg4n5Scb3ZM8QiZIQQXUbXpl5k3PXkczj+lJ2JkMAkJZ0vTFPAzo
 AI+uK6MDywGiCleiIYO1jyfFfMh3cLLcyGIfXtWI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1k3IIa-0001gS-Ol; Wed, 05 Aug 2020 13:13:36 +0100
MIME-Version: 1.0
Date: Wed, 05 Aug 2020 13:13:36 +0100
From: Marc Zyngier <maz@kernel.org>
To: Jingyi Wang <wangjingyi11@huawei.com>
Subject: Re: [kvm-unit-tests PATCH v3 00/10] arm/arm64: Add IPI/LPI/vtimer
 latency test
In-Reply-To: <957a4657-7e17-b173-ea4d-10c29ab9e3cd@huawei.com>
References: <20200731074244.20432-1-wangjingyi11@huawei.com>
 <957a4657-7e17-b173-ea4d-10c29ab9e3cd@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <0bd81d1da9040fce660af46763507ac2@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangjingyi11@huawei.com, drjones@redhat.com,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
 wanghaibin.wang@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
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

On 2020-08-05 12:54, Jingyi Wang wrote:
> Hi all,
> 
> Currently, kvm-unit-tests only support GICv3 vLPI injection. May I ask
> is there any plan or suggestion on constructing irq bypass mechanism
> to test vLPI direct injection in kvm-unit-tests?

I'm not sure what you are asking for here. VLPIs are only delivered
from a HW device, and the offloading mechanism isn't visible from
userspace (you either have an enabled GICv4 implementation, or
you don't).

There are ways to *trigger* device MSIs from userspace and inject
them in a guest, but that's only a debug feature, which shouldn't
be enabled on a production system.

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
