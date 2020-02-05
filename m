Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB0153B38
	for <lists+kvmarm@lfdr.de>; Wed,  5 Feb 2020 23:45:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 1A6B74A5BD;
	Wed,  5 Feb 2020 17:45:23 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.909
X-Spam-Level: 
X-Spam-Status: No, score=0.909 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@redhat.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vl4ljvMfp60R; Wed,  5 Feb 2020 17:45:22 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 024214A598;
	Wed,  5 Feb 2020 17:45:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id B07034A524
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Feb 2020 17:45:20 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3aaaTGB2ipLX for <kvmarm@lists.cs.columbia.edu>;
 Wed,  5 Feb 2020 17:45:19 -0500 (EST)
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id CEAD24A418
 for <kvmarm@lists.cs.columbia.edu>; Wed,  5 Feb 2020 17:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLW36RQDcQlBWq87U9OJm0bMCerLux+JLB20TQpqI/c=;
 b=fynN7DoZQR2/2OgHT3zT99gexl2ZayKv8mm2HrBGXGumU5x8j6xYc+BcParpbbFa3q2rkT
 d+ePtcPA/Ojctsi7MgjxH8hkIbG8IZttKL3K8YZz4Pf4jlryU2alZ6UKlEmnMzGY52vvqQ
 uEcbBM3mkIkzOGaraBiHmDXtfABxv4E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-TbNv-J54Pr-JZw-BY4ULKA-1; Wed, 05 Feb 2020 17:45:17 -0500
Received: by mail-qk1-f200.google.com with SMTP id z1so2324634qkl.15
 for <kvmarm@lists.cs.columbia.edu>; Wed, 05 Feb 2020 14:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qhu3K4UfMyr9rLuPVrEXyLiBiRw+0bLNH6EYh61xjr4=;
 b=FC0LLBwunij3q/n9GkbpyrQNV60vM12K7qSCVn54xtcJFN3Sm8UC8U+4f6rQI0D7kK
 5P3+QD1ATsD7o0o53lPtkkmk0yd9+thNCXpbF3R1V7ML1dCHz+ehz6ZjpwGXAkqmMBv0
 as2ylvvMkXfxIextt106Fn2OsdDQFLZHdTItM3T5AidhHlkNYcTYlL+cCCJvqAxYVvf0
 +6oaG9krObhZSd99OF2EV0pcyaJ9P3fUui18PgR/uYYuyQebvh2W5EH/4l6YL0wqi+ES
 N3zCTcsINTjUAQw30mLPHzp0rfamsleDri0jfTQI4Gf5LBSgmBBB3C/lTzvo/SV4uptO
 9WZg==
X-Gm-Message-State: APjAAAXxIpNpIYfGSv02/f0/klM+vaEh7dmz0S6F6aUW6JW0o3CfGrk4
 soSsLSbTVvo9cm61DYWHUz5rj77xCUS/tqVsTmj3jAqypuLVm5dYDvDpKZl5zziJsMRZq0DVpru
 KSjs669FqO4yxbBtkBwWx5g/d
X-Received: by 2002:a05:620a:1654:: with SMTP id
 c20mr61832qko.116.1580942717358; 
 Wed, 05 Feb 2020 14:45:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAvhOweFr4KXXnP5Mb9+7dhUBLh1Z13T+81iDjtWqZt6EK3UE5xX8DXWaSS5tvfd+S4d7C7g==
X-Received: by 2002:a05:620a:1654:: with SMTP id
 c20mr61812qko.116.1580942717130; 
 Wed, 05 Feb 2020 14:45:17 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id x22sm615496qtq.30.2020.02.05.14.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 14:45:16 -0800 (PST)
Date: Wed, 5 Feb 2020 17:45:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v5 06/19] KVM: Drop kvm_arch_create_memslot()
Message-ID: <20200205224513.GH387680@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-7-sean.j.christopherson@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200121223157.15263-7-sean.j.christopherson@intel.com>
X-MC-Unique: TbNv-J54Pr-JZw-BY4ULKA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, linux-mips@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, kvmarm@lists.cs.columbia.edu,
 Janosch Frank <frankja@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
 kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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

On Tue, Jan 21, 2020 at 02:31:44PM -0800, Sean Christopherson wrote:
> Remove kvm_arch_create_memslot() now that all arch implementations are
> effectively nops.  Removing kvm_arch_create_memslot() eliminates the
> possibility for arch specific code to allocate memory prior to setting
> a memslot, which sets the stage for simplifying kvm_free_memslot().
> 
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
