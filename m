Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B7E05D2
	for <lists+kvmarm@lfdr.de>; Tue, 22 Oct 2019 16:04:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id ADEC34A99B;
	Tue, 22 Oct 2019 10:04:29 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -4.202
X-Spam-Level: 
X-Spam-Status: No, score=-4.202 required=6.1 tests=[BAYES_00=-1.9,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_HI=-5, SPF_HELO_PASS=-0.001]
	autolearn=unavailable
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QP7cRtfrDMxD; Tue, 22 Oct 2019 10:04:28 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 9AC754A995;
	Tue, 22 Oct 2019 10:04:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 49E2A4A97C
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Oct 2019 10:04:27 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FaDFSqDJRCec for <kvmarm@lists.cs.columbia.edu>;
 Tue, 22 Oct 2019 10:04:26 -0400 (EDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 521A24A981
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Oct 2019 10:04:26 -0400 (EDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F56081F19
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Oct 2019 14:04:25 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e25so8649493wra.9
 for <kvmarm@lists.cs.columbia.edu>; Tue, 22 Oct 2019 07:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3vKquIIhS417Xcv3ef04W52oBIikgSSCS3LfBkCoIDs=;
 b=U2g3pKZtHb0DAtjzaklZCNsXZcWqh9vX8i1I0vgISYA2dymX7TqkePxa/SAKzIowW8
 s9xPn1o4gaNOzX1pMgswsRindTA7qcuXge5DCzWLQTgeNV03wpdK4d2W5frQuonJz/WS
 eVB+oeVV8lO6XoYI7M7NYopccmGNWCLMA1addjWf5x14sB5WDA4g8EkYz+N/nY4Pjrju
 ooRwSNXI7m+IlhMoifNa1N52IgYLH8jfTIiQPs/SIX0NheznD1/ZdkoTVNv1cK0Loask
 eAGVS/+2QlE7xmi+jEEzOJ2gUFNgPqEWmQPh/mFLwduTe/j359SDlRAz6dugApwqGKvC
 FYpA==
X-Gm-Message-State: APjAAAV+JcHrLRSJ7hy0/XQSRpLVjD3jpxGQF7Lf3rfqVh1/BwDpRSYd
 O4tcISL1fgPUl0anBppElcWfz4OVff7TFUoIUDrvQfTs3JToJxqjykCGT/wdVSCMqHdVTu244Sj
 sDpu/hPbf/8DSl71wZDv3LyK8
X-Received: by 2002:a7b:c049:: with SMTP id u9mr3176819wmc.12.1571753064233;
 Tue, 22 Oct 2019 07:04:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxd12WGZ28CK/g1W21d1r/6V7p9tDfXwdcdM4EXY3TusWKTyDA7mRoL7a/JX5NzrrGKErwrww==
X-Received: by 2002:a7b:c049:: with SMTP id u9mr3176775wmc.12.1571753063926;
 Tue, 22 Oct 2019 07:04:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19?
 ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
 by smtp.gmail.com with ESMTPSA id n11sm903226wmd.26.2019.10.22.07.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 07:04:23 -0700 (PDT)
Subject: Re: [PATCH v2 15/15] KVM: Dynamically size memslot array based on
 number of used slots
To: Sean Christopherson <sean.j.christopherson@intel.com>,
 James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, Marc Zyngier <maz@kernel.org>
References: <20191022003537.13013-1-sean.j.christopherson@intel.com>
 <20191022003537.13013-16-sean.j.christopherson@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2609aedc-4fc9-ab92-8877-55c64cf19165@redhat.com>
Date: Tue, 22 Oct 2019 16:04:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022003537.13013-16-sean.j.christopherson@intel.com>
Content-Language: en-US
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
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

On 22/10/19 02:35, Sean Christopherson wrote:
> +	struct kvm_memory_slot memslots[];
> +	/*
> +	 * WARNING: 'memslots' is dynamically-sized.  It *MUST* be at the end.
> +	 */

Isn't that obvious from the flexible array member?

Paolo
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
