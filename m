Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D479A43CF02
	for <lists+kvmarm@lfdr.de>; Wed, 27 Oct 2021 18:50:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 77DDB4B15B;
	Wed, 27 Oct 2021 12:50:06 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.391
X-Spam-Level: 
X-Spam-Status: No, score=-1.391 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@quicinc.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v5ccRMhVK-5j; Wed, 27 Oct 2021 12:50:05 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 702CC4B175;
	Wed, 27 Oct 2021 12:49:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 339A64B136
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Oct 2021 11:17:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6xVHT+S7621y for <kvmarm@lists.cs.columbia.edu>;
 Wed, 27 Oct 2021 11:17:37 -0400 (EDT)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 971F34B135
 for <kvmarm@lists.cs.columbia.edu>; Wed, 27 Oct 2021 11:17:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1635347857; x=1666883857;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=EB+uKYDyfMVWPXxIP3rU1BgAPz0x6oZw2Oj6xwGMrMc=;
 b=y9948G41SWHhK4bj3PMLfREYwyqjzHRX6LrpIX8fUFd7Pw2mgLBcgXOm
 9nvTs7pjuH6SmxnPM+bqtty1UTPgdXebzkE0vWNl62A1FutlHEU8CcNPb
 2kit4OFhMd0Y4YO75ws9VaG+Ext8UGc/koOYNoboYZAW/9ddM23in0gvt w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
 by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 08:17:36 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
 by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 08:17:36 -0700
Received: from [10.110.114.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 27 Oct 2021
 08:17:35 -0700
Subject: Re: [PATCH] KVM: arm64: Remove unused TRNG_NO_ENTROPY
To: Marc Zyngier <maz@kernel.org>
References: <20211026210913.57006-1-quic_qiancai@quicinc.com>
 <3fac8ddb626205286f79adde96ea527b@kernel.org>
From: Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <4a1a720a-3818-b4de-d549-939473c63fda@quicinc.com>
Date: Wed, 27 Oct 2021 11:17:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3fac8ddb626205286f79adde96ea527b@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Mailman-Approved-At: Wed, 27 Oct 2021 12:49:56 -0400
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, Catalin Marinas <catalin.marinas@arm.com>,
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



On 10/27/21 3:46 AM, Marc Zyngier wrote:
> That's an architectural definition that doesn't cause any problem.
> If anything, that's documentation.
> 
> We have *tons* of other definitions with no user all over the
> arm64 code. They save the exact same purpose.

Understood. Thanks for the quick feedback, guys!
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
