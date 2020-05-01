Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 61C561C1030
	for <lists+kvmarm@lfdr.de>; Fri,  1 May 2020 11:11:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D29B54B5A8;
	Fri,  1 May 2020 05:11:58 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.501
X-Spam-Level: 
X-Spam-Status: No, score=-1.501 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_MED=-2.3]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdJKpadHffV0; Fri,  1 May 2020 05:11:58 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id D0DF64B58C;
	Fri,  1 May 2020 05:11:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id AFE994B4E8
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 May 2020 05:11:56 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSgYpQaW90M9 for <kvmarm@lists.cs.columbia.edu>;
 Fri,  1 May 2020 05:11:55 -0400 (EDT)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A85E54B3C1
 for <kvmarm@lists.cs.columbia.edu>; Fri,  1 May 2020 05:11:55 -0400 (EDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC5A1FB;
 Fri,  1 May 2020 02:11:55 -0700 (PDT)
Received: from [10.37.12.139] (unknown [10.37.12.139])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1BE3F305;
 Fri,  1 May 2020 02:11:53 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] KVM: arm64: Kill off CONFIG_KVM_ARM_HOST
To: tabba@google.com, maz@kernel.org, catalin.marinas@arm.com,
 julien.thierry.kdev@gmail.com, kvmarm@lists.cs.columbia.edu
References: <20200421131734.141766-1-tabba@google.com>
 <20200421131734.141766-2-tabba@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a9c69431-5d04-fd5c-9705-b609d326d468@arm.com>
Date: Fri, 1 May 2020 10:16:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200421131734.141766-2-tabba@google.com>
Content-Language: en-US
Cc: will@kernel.org
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

On 04/21/2020 02:17 PM, Fuad Tabba wrote:
> From: Will Deacon <will@kernel.org>
> 
> CONFIG_KVM_ARM_HOST is just a proxy for CONFIG_KVM, so remove it in favour
> of the latter.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Fuad Tabba <tabba@google.com>


Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
