Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 6169E1F1C51
	for <lists+kvmarm@lfdr.de>; Mon,  8 Jun 2020 17:42:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id E01A54B1B3;
	Mon,  8 Jun 2020 11:42:49 -0400 (EDT)
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
	with ESMTP id fXBDB1FUGlzT; Mon,  8 Jun 2020 11:42:49 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 920964B1A1;
	Mon,  8 Jun 2020 11:42:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 015774B127
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 11:42:47 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I+cOyRNL281w for <kvmarm@lists.cs.columbia.edu>;
 Mon,  8 Jun 2020 11:42:46 -0400 (EDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 06D4B4B121
 for <kvmarm@lists.cs.columbia.edu>; Mon,  8 Jun 2020 11:42:46 -0400 (EDT)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95938206C3;
 Mon,  8 Jun 2020 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591630964;
 bh=CcGUQFrKPbxqqYBdQSn7aunL0vzndo8c/yOQ5BBHLhQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gBsMPDJNjtGVl/jmnBcUHW9bDu1wu5RUrfh/1SfTLUiFY9kxCvC5tQUVcjiqdrRRg
 zGGKnhrKBC457xtfkyzZ/VmOelipN92/chg1ZHo2VW/x7+ZbYKfv8HrPuPDRxrpVi2
 DYRPtJFy+eJEeof/DFhqUmsnS7BqRQ8/XLbheQjI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jiJv9-001A5n-3f; Mon, 08 Jun 2020 16:42:43 +0100
MIME-Version: 1.0
Date: Mon, 08 Jun 2020 16:42:42 +0100
From: Marc Zyngier <maz@kernel.org>
To: Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v2] KVM: arm64: Remove host_cpu_context member from vcpu
 structure
In-Reply-To: <20200608145145.GA96714@google.com>
References: <20200608085657.1405730-1-maz@kernel.org>
 <20200608145145.GA96714@google.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <1a00887a4af019fa83380b68afd43a29@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ascull@google.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
 mark.rutland@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: kvm@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
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

Hi Andrew,

On 2020-06-08 15:51, Andrew Scull wrote:
> On Mon, Jun 08, 2020 at 09:56:57AM +0100, Marc Zyngier wrote:
>> For very long, we have kept this pointer back to the per-cpu
>> host state, despite having working per-cpu accessors at EL2
>> for some time now.
>> 
>> Recent investigations have shown that this pointer is easy
>> to abuse in preemptible context, which is a sure sign that
>> it would better be gone. Not to mention that a per-cpu
>> pointer is faster to access at all times.
> 
> Helps to make the references to `kvm_host_data` clearer with there now
> being just one way to get to it and shows that it is scoped to the
> current CPU. A good change IMO!

Thanks! Can I take this as a Reviewed-by or Acked-by tag? Just let me 
know.

Cheers,

          M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
